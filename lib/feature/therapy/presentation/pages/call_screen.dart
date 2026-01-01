import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:navithera_client/core/constants/emoji_list.dart';
import 'package:navithera_client/feature/therapy/presentation/widgets/animated_gradient_background.dart';
import 'package:navithera_client/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/one_to_one_call_provider.dart';
import '../services/pip_manager.dart';

class CallScreen extends ConsumerStatefulWidget {
  final String? roomName;
  final String? participantName;
  final bool isVideoCall;
  final String? chatId;
  final bool isResumingFromPiP;

  const CallScreen({
    super.key,
    this.roomName,
    this.participantName,
    this.isVideoCall = false,
    this.chatId,
    this.isResumingFromPiP = false,
  });

  @override
  ConsumerState<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  final Size _previewSize = const Size(120, 160);
  Offset _previewOffset = const Offset(0, 0);
  final EdgeInsets _previewPadding = const EdgeInsets.fromLTRB(12, 12, 12, 120);

  // When true, show local feed as the large/main; when false, remote is large/main.
  bool _isSwitched = false;

  StreamSubscription<RemoteMessage>? _notificationSubscription;

  @override
  void initState() {
    super.initState();
    _setupNotificationListener();

    // Only start call if not resuming from PiP
    if (!widget.isResumingFromPiP) {
      // Start call on next microtask to avoid Riverpod lifecycle issues
      Future.microtask(_startCall);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      setState(() {
        _previewOffset = _bottomRightFor(size);
      });
    });
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    super.dispose();
  }

  Future<void> EndCall({
    String chatId = "513522dc-2ff2-4bde-a31d-1bcc8f3884c7",
  }) async {
    final Dio dio = Dio();
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final accessToken = sharedPreferences.getString('access_token');

      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await dio.post('${base_url_dev}/chat/call/end/$chatId');

      if (response.statusCode == 201) {
        // Call ended successfullprint
        print("Call ended, Test phone #1");
      }
    } catch (e) {
      // Optional: log error
    }
  }

  void _setupNotificationListener() {
    _notificationSubscription = FirebaseMessaging.onMessage.listen((
      RemoteMessage message,
    ) {
      final title = message.notification?.title;
      if (title == 'Call Rejected' || title == 'Call Ended') {
        _onCallRejected(title ?? 'Call Ended');
      }
    });
  }

  void _onCallRejected(String title) {
    if (!mounted) return;
    ref.read(callControllerProvider.notifier).endCall();
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title by the other party'),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      ),
    );
  }

  Offset _bottomRightFor(Size screen) {
    final right = _previewPadding.right;
    final bottom = _previewPadding.bottom;
    return Offset(
      screen.width - _previewSize.width - right,
      screen.height - _previewSize.height - bottom,
    );
  }

  Offset _clampToBounds(Offset candidate, Size screen) {
    final minX = _previewPadding.left;
    final minY = _previewPadding.top;
    final maxX = screen.width - _previewSize.width - _previewPadding.right;
    final maxY = screen.height - _previewSize.height - _previewPadding.bottom;
    return Offset(
      candidate.dx.clamp(minX, maxX),
      candidate.dy.clamp(minY, maxY),
    );
  }

  Future<void> _startCall() async {
    final roomName = widget.roomName ?? 'default-room';
    final participantName =
        widget.participantName ??
        'User-${DateTime.now().millisecondsSinceEpoch}';

    await ref
        .read(callControllerProvider.notifier)
        .startCall(
          roomName: roomName,
          participantName: participantName,
          isVideoCall: widget.isVideoCall,
        );
  }

  void _activatePiP() {
    ref
        .read(pipManagerProvider.notifier)
        .showPiP(
          context: context,
          roomName: widget.roomName,
          participantName: widget.participantName,
          isVideoCall: widget.isVideoCall,
          chatId: widget.chatId,
          onExpand: () {
            navigatorKey.currentState?.push(
              MaterialPageRoute(
                builder:
                    (context) => CallScreen(
                      roomName: widget.roomName,
                      participantName: widget.participantName,
                      isVideoCall: widget.isVideoCall,
                      chatId: widget.chatId,
                      isResumingFromPiP: true,
                    ),
              ),
            );
          },
          onClose: () {
            ref.read(callControllerProvider.notifier).endCall();
          },
        );

    Navigator.of(context).pop();
  }

  String _getDisplayInitials(String? name) {
    if (name == null || name.isEmpty) return '?';
    final words = name.trim().split(' ');
    if (words.length >= 2) {
      return '${words.first[0].toUpperCase()}${words.last[0].toUpperCase()}';
    } else {
      return name.length >= 2
          ? '${name[0].toUpperCase()}${name[1].toUpperCase()}'
          : name[0].toUpperCase();
    }
  }

  String _getFirstName(String? name) {
    if (name == null || name.isEmpty) return 'Unknown';
    return name.trim().split(' ').first;
  }

  List<String> roomNameToEmojis(String roomName, {int emojiCount = 4}) {
    final hash = roomName.codeUnits.fold(0, (a, b) => a + b);
    final emojis = <String>[];
    for (int i = 0; i < emojiCount; i++) {
      final index = (hash + i * 31) % emojiList.length;
      emojis.add(emojiList[index]);
    }
    return emojis;
  }

  void _endAndPopIfMounted() {
    if (!mounted) return;
    if (widget.chatId != null) {
      EndCall(chatId: widget.chatId!);
    }
    ref.read(callControllerProvider.notifier).endCall();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final callState = ref.watch(callControllerProvider);
    final participantTracks = ref.watch(participantTracksProvider);

    final localTracks = participantTracks.where(
      (t) => t.participant is LocalParticipant,
    );
    final local = localTracks.isNotEmpty ? localTracks.first : null;

    final remoteParticipants =
        participantTracks
            .where((t) => t.participant is! LocalParticipant)
            .toList();

    final hasSingleRemote = remoteParticipants.length == 1;
    final firstRemote = hasSingleRemote ? remoteParticipants.first : null;

    // UI flags based on actual track availability AND participant enabled state
    final isLocalVideoEnabled =
        local?.participant.isCameraEnabled() == true &&
        local?.videoTrack != null;
    final isRemoteVideoEnabled =
        hasSingleRemote &&
        firstRemote != null &&
        firstRemote.participant.isCameraEnabled() &&
        firstRemote.videoTrack != null;

    final isAudioOnlyMode = !widget.isVideoCall;

    if (callState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _endAndPopIfMounted();
      });
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Stack(
          children: [
            if (!isAudioOnlyMode)
              ..._buildBackgroundVideoLayers(
                local: local,
                firstRemote: firstRemote,
                isLocalVideoEnabled: isLocalVideoEnabled,
                isRemoteVideoEnabled: isRemoteVideoEnabled,
              ),

            if (isAudioOnlyMode ||
                (!isLocalVideoEnabled && !isRemoteVideoEnabled))
              AnimatedGradientBackground(),

            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHeader(callState),
                  Expanded(
                    child: _buildMainContent(
                      callState,
                      participantTracks,
                      isLocalVideoEnabled:
                          !isAudioOnlyMode && isLocalVideoEnabled,
                      isRemoteVideoEnabled:
                          !isAudioOnlyMode && isRemoteVideoEnabled,
                    ),
                  ),
                  _buildControls(callState, isAudioOnlyMode: isAudioOnlyMode),
                ],
              ),
            ),

            if (!isAudioOnlyMode &&
                isLocalVideoEnabled &&
                isRemoteVideoEnabled &&
                hasSingleRemote &&
                firstRemote != null &&
                local != null)
              Positioned(
                left: _previewOffset.dx,
                top: _previewOffset.dy,
                width: _previewSize.width,
                height: _previewSize.height,
                child: _buildDraggablePreview(
                  mainIsLocal: _isSwitched,
                  local: local,
                  remote: firstRemote,
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBackgroundVideoLayers({
    required ParticipantTrack? local,
    required ParticipantTrack? firstRemote,
    required bool isLocalVideoEnabled,
    required bool isRemoteVideoEnabled,
  }) {
    if (_isSwitched && !isLocalVideoEnabled && isRemoteVideoEnabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _isSwitched = false;
          });
        }
      });
    } else if (!_isSwitched && !isRemoteVideoEnabled && isLocalVideoEnabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _isSwitched = true;
          });
        }
      });
    }

    final showLocalFull =
        (isLocalVideoEnabled && _isSwitched) ||
        (isLocalVideoEnabled && !isRemoteVideoEnabled);

    final showRemoteFull =
        (isRemoteVideoEnabled && !_isSwitched) ||
        (isRemoteVideoEnabled && !isLocalVideoEnabled);

    final layers = <Widget>[];

    if (showRemoteFull && firstRemote?.videoTrack != null) {
      layers.add(
        VideoTrackRenderer(
          firstRemote!.videoTrack!,
          fit: VideoViewFit.cover,
          renderMode: VideoRenderMode.auto,
        ),
      );
    }

    if (showLocalFull && local?.videoTrack != null) {
      layers.add(
        Positioned.fill(
          child: VideoTrackRenderer(
            local!.videoTrack!,
            fit: VideoViewFit.cover,
            renderMode: VideoRenderMode.auto,
          ),
        ),
      );
    }

    return layers;
  }

  Widget _buildHeader(CallState callState) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: GestureDetector(
              onTap: () {
                _activatePiP();
              },
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          GestureDetector(
            onLongPress: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  roomNameToEmojis(callState.roomName ?? 'default-room')
                      .map(
                        (emoji) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            emoji,
                            style: const TextStyle(fontSize: 22),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
          const SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }

  Widget _buildMainContent(
    CallState callState,
    List<ParticipantTrack> participantTracks, {
    required bool isLocalVideoEnabled,
    required bool isRemoteVideoEnabled,
  }) {
    if (callState.isConnecting) {
      return Center(
        child: _buildAvatar(
          widget.participantName ?? 'Participant',
          "Calling...",
        ),
      );
    }

    if (callState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 64),
            const SizedBox(height: 16),
            Text(
              'Error: ${callState.error}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(callControllerProvider.notifier).clearError();
                _startCall();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (!callState.isConnected) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.call_end, color: Colors.red, size: 64),
            SizedBox(height: 16),
            Text(
              'Call ended',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      );
    }

    final remoteParticipants =
        participantTracks
            .where((t) => t.participant is! LocalParticipant)
            .toList();

    if (remoteParticipants.isEmpty && !isLocalVideoEnabled) {
      return Center(
        child: _buildAvatar(
          widget.participantName ?? 'Participant',
          "Calling...",
        ),
      );
    }

    if (remoteParticipants.length == 1 &&
        !(isLocalVideoEnabled || isRemoteVideoEnabled)) {
      return Center(
        child: _buildAvatar(widget.participantName ?? 'Participant', "..."),
      );
    }

    if (remoteParticipants.length >= 2) {
      return _buildGrid(remoteParticipants);
    }

    return const SizedBox.shrink();
  }

  Widget _buildAvatar(String name, String status) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: Center(
            child: Text(
              _getDisplayInitials(name),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          _getFirstName(name),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 4),
            Text(
              status == "ring" ? 'Ringing...' : status,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGrid(List<ParticipantTrack> remoteParticipants) {
    final count = remoteParticipants.length;
    int crossAxisCount;
    double aspectRatio;

    if (count == 1) {
      crossAxisCount = 1;
      aspectRatio = 9 / 16;
    } else if (count == 2) {
      crossAxisCount = 1;
      aspectRatio = 16 / 9;
    } else if (count <= 4) {
      crossAxisCount = 2;
      aspectRatio = 4 / 3;
    } else {
      crossAxisCount = 3;
      aspectRatio = 1;
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: aspectRatio,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: remoteParticipants.length,
        itemBuilder: (context, index) {
          final track = remoteParticipants[index];
          return _buildVideoTile(track);
        },
      ),
    );
  }

  Widget _buildVideoTile(ParticipantTrack track) {
    final hasVideo =
        track.videoTrack != null && track.participant.isCameraEnabled();

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          if (hasVideo)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox.expand(
                child: VideoTrackRenderer(
                  track.videoTrack!,
                  renderMode: VideoRenderMode.auto,
                  fit: VideoViewFit.cover,
                ),
              ),
            )
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.red.shade600,
                    child: Text(
                      _getDisplayInitials(track.participant.name),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _getFirstName(track.participant.identity),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    track.participant.isMicrophoneEnabled()
                        ? Icons.mic
                        : Icons.mic_off,
                    color:
                        track.participant.isMicrophoneEnabled()
                            ? Colors.white
                            : Colors.red,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      track.participant is LocalParticipant
                          ? 'You'
                          : _getFirstName(track.participant.name),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    track.participant.isCameraEnabled()
                        ? Icons.videocam
                        : Icons.videocam_off,
                    color:
                        track.participant.isCameraEnabled()
                            ? Colors.white
                            : Colors.red,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggablePreview({
    required bool mainIsLocal,
    required ParticipantTrack local,
    required ParticipantTrack remote,
  }) {
    final previewTrack = mainIsLocal ? remote : local;
    Offset dragStartOffset = _previewOffset;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSwitched = !_isSwitched;
        });
      },
      onPanStart: (details) {
        dragStartOffset = _previewOffset;
      },
      onPanUpdate: (details) {
        final size = MediaQuery.of(context).size;
        final next = Offset(
          dragStartOffset.dx + details.delta.dx,
          dragStartOffset.dy + details.delta.dy,
        );
        setState(() {
          _previewOffset = _clampToBounds(next, size);
          dragStartOffset = _previewOffset;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.black,
          child: AbsorbPointer(
            absorbing: true,
            child: VideoTrackRenderer(
              previewTrack.videoTrack!,
              renderMode: VideoRenderMode.auto,
              fit: VideoViewFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControls(CallState callState, {required bool isAudioOnlyMode}) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(
            icon: callState.isMicMuted ? Icons.mic_off : Icons.mic,
            isActive: !callState.isMicMuted,
            onPressed:
                () =>
                    ref
                        .read(callControllerProvider.notifier)
                        .toggleMicrophone(),
            backgroundColor: callState.isMicMuted ? Colors.white : null,
            label: 'Mute',
          ),
          if (widget.isVideoCall)
            _buildControlButton(
              icon: callState.isCameraOff ? Icons.videocam_off : Icons.videocam,
              isActive: !callState.isCameraOff,
              onPressed:
                  () => {
                    ref.read(callControllerProvider.notifier).toggleCamera(),
                  },
              backgroundColor: callState.isCameraOff ? Colors.red : null,
              label: 'Camera',
            ),
          _buildControlButton(
            icon: callState.isSpeakerOn ? Icons.volume_up : Icons.volume_down,
            isActive: !callState.isSpeakerOn,
            onPressed:
                () => ref.read(callControllerProvider.notifier).toggleSpeaker(),
            backgroundColor: callState.isSpeakerOn ? Colors.white : null,
            label: 'Speaker',
          ),
          _buildControlButton(
            icon: Icons.call_end,
            onPressed: () {
              if (widget.chatId != null) {
                EndCall(chatId: widget.chatId!);
              }
              ref.read(callControllerProvider.notifier).endCall();
              Navigator.of(context).pop();
            },
            backgroundColor: Colors.red,
            isDestructive: true,
            label: 'End',
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    bool isActive = true,
    Color? backgroundColor,
    bool isDestructive = false,
    String label = '',
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color:
                backgroundColor ?? (isActive ? Colors.white24 : Colors.white12),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color:
                  isDestructive
                      ? Colors.white
                      : (isActive ? Colors.white : Colors.grey),
              size: 28,
            ),
            iconSize: 28,
            padding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
