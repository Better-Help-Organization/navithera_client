import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:navithera_client/core/constants/emoji_list.dart';
import 'package:navithera_client/core/util/format_duration.dart';
import 'package:navithera_client/feature/therapy/presentation/widgets/animated_gradient_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/call_provider.dart';

/// Dedicated screen for group video calls with multiple participants
/// Shows each participant's name on their video tile
class GroupCallScreen extends ConsumerStatefulWidget {
  final String? roomName;
  final String? participantName;
  final bool isVideoCall;
  final String? chatId;
  final bool isResumingFromPiP;
  final String? callerName; // Name of the person who initiated the call
  final int? callerAvatar; // Avatar number of the caller

  const GroupCallScreen({
    super.key,
    this.roomName,
    this.participantName,
    this.isVideoCall = false,
    this.chatId,
    this.isResumingFromPiP = false,
    this.callerName,
    this.callerAvatar,
  });

  @override
  ConsumerState<GroupCallScreen> createState() => _GroupCallScreenState();
}

class _GroupCallScreenState extends ConsumerState<GroupCallScreen> {
  StreamSubscription<RemoteMessage>? _notificationSubscription;

  @override
  void initState() {
    super.initState();
    _setupNotificationListener();

    // Only start call if not resuming from PiP
    if (!widget.isResumingFromPiP) {
      Future.microtask(_startCall);
    }
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _startCall() async {
    final roomName = widget.roomName ?? 'default-room';
    final participantName =
        widget.participantName ??
        'User-${DateTime.now().millisecondsSinceEpoch}';

    print('📱 GroupCallScreen: Starting call');
    print('   Room: $roomName');
    print('   Participant: $participantName');
    print('   IsVideo: ${widget.isVideoCall}');
    print('   ChatId: ${widget.chatId}');

    await ref
        .read(callControllerProvider.notifier)
        .startCall(
          roomName: roomName,
          participantName: participantName,
          isVideoCall: widget.isVideoCall,
        );
  }

  Future<void> EndCall({required String chatId}) async {
    final Dio dio = Dio();
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final accessToken = sharedPreferences.getString('access_token');

      dio.options.headers['Authorization'] = 'Bearer $accessToken';
      await dio.post('${base_url_dev}/chat/call/end/$chatId');
    } catch (e) {
      // Optional: log error
    }
  }

  void _setupNotificationListener() {
    _notificationSubscription = FirebaseMessaging.onMessage.listen((message) {
      final title = message.notification?.title;
      if (title == 'Call Rejected' || title == 'Call Ended') {
        _onCallEnded(title ?? 'Call Ended');
      }
    });
  }

  void _onCallEnded(String title) {
    if (!mounted) return;
    ref.read(callControllerProvider.notifier).endCall();
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title by another party'),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      ),
    );
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

    // Separate local and remote participants
    final localTracks = participantTracks.where(
      (t) => t.participant is LocalParticipant,
    );
    final local = localTracks.isNotEmpty ? localTracks.first : null;

    final remoteParticipants =
        participantTracks
            .where((t) => t.participant is! LocalParticipant)
            .toList();

    // For group calls, we want to show all participants in a grid
    final allParticipantsForGrid = <ParticipantTrack>[
      if (local != null) local,
      ...remoteParticipants,
    ];

    if (callState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _endAndPopIfMounted();
      });
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Stack(
          children: [
            // Background gradient when videos are off
            if (!widget.isVideoCall) AnimatedGradientBackground(),

            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHeader(callState, remoteParticipants.length + 1),
                  Expanded(
                    child: _buildMainContent(callState, allParticipantsForGrid),
                  ),
                  _buildControls(callState),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(CallState callState, int participantCount) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Participant count
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatDuration(callState.callDuration),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$participantCount ${participantCount == 1 ? "person" : "people"}',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),

          // Room emoji signature
          Row(
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

          const SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }

  Widget _buildMainContent(
    CallState callState,
    List<ParticipantTrack> allParticipants,
  ) {
    if (callState.isConnecting) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 20),
            Text(
              'Joining group call...',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
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

    // Show grid of all participants
    return _buildParticipantsGrid(allParticipants);
  }

  Widget _buildParticipantsGrid(List<ParticipantTrack> participants) {
    if (participants.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'Waiting for participants...',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      );
    }

    final count = participants.length;
    int crossAxisCount;
    double aspectRatio;

    // Responsive grid layout based on participant count
    if (count == 1) {
      crossAxisCount = 1;
      aspectRatio = 9 / 16;
    } else if (count == 2) {
      crossAxisCount = 2;
      aspectRatio = 9 / 16;
    } else if (count <= 4) {
      crossAxisCount = 2;
      aspectRatio = 4 / 3;
    } else if (count <= 6) {
      crossAxisCount = 2;
      aspectRatio = 1;
    } else if (count <= 9) {
      crossAxisCount = 3;
      aspectRatio = 1;
    } else {
      crossAxisCount = 4;
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
        itemCount: participants.length,
        itemBuilder: (context, index) {
          final track = participants[index];
          return _buildParticipantTile(track);
        },
      ),
    );
  }

  Widget _buildParticipantTile(ParticipantTrack track) {
    final isLocal = track.participant is LocalParticipant;

    // CHECK: If we have a valid video track, we should render it,
    // regardless of what the metadata says.
    final hasVideo = track.videoTrack != null && !track.videoTrack!.muted;

    final isMuted = !track.participant.isMicrophoneEnabled();
    final displayName = isLocal ? 'You' : _getFirstName(track.participant.name);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video feed or avatar
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
                    radius: 40,
                    backgroundColor:
                        isLocal ? Colors.blue.shade600 : Colors.teal.shade600,
                    child: Text(
                      _getDisplayInitials(track.participant.name),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // ... rest of your UI (Username overlay, etc) remains exactly the same ...
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
                    isMuted ? Icons.mic_off : Icons.mic,
                    color: isMuted ? Colors.red : Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    // Use hasVideo check here for the icon too
                    hasVideo ? Icons.videocam : Icons.videocam_off,
                    color: hasVideo ? Colors.white : Colors.red,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),

          if (isLocal)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'You',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildControls(CallState callState) {
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
            backgroundColor: callState.isMicMuted ? Colors.red : null,
            label: 'Mic',
          ),
          if (widget.isVideoCall)
            _buildControlButton(
              icon: callState.isCameraOff ? Icons.videocam_off : Icons.videocam,
              isActive: !callState.isCameraOff,
              onPressed:
                  () =>
                      ref.read(callControllerProvider.notifier).toggleCamera(),
              backgroundColor: callState.isCameraOff ? Colors.red : null,
              label: 'Camera',
            ),
          _buildControlButton(
            icon: callState.isSpeakerOn ? Icons.volume_up : Icons.volume_down,
            isActive: callState.isSpeakerOn,
            onPressed:
                () => ref.read(callControllerProvider.notifier).toggleSpeaker(),
            backgroundColor: callState.isSpeakerOn ? Colors.white24 : null,
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
            label: 'Leave',
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
