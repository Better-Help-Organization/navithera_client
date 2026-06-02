import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/feature/therapy/presentation/services/pip_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

import '../exts.dart';
import '../utils.dart';
import '../widgets/controls.dart';
import '../widgets/participant.dart';
import '../widgets/participant_info.dart';
import '../widgets/sound_waveform.dart';

class RoomPage extends ConsumerStatefulWidget {
  final Room room;
  final EventsListener<RoomEvent> listener;
  final bool showVideoControl;
  final String chatId;
  final bool isGroup;

  const RoomPage(
    this.room,
    this.listener, {
    this.showVideoControl = true,
    super.key,
    this.chatId = "",
    this.isGroup = false,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoomPageState();
}

class _RoomPageState extends ConsumerState<RoomPage> {
  static const _emojiCandidates = [
    '🎨',
    '📡',
    '🇮🇹',
    '💂',
    '🦁',
    '🐯',
    '🎱',
    '🎲',
    '🎸',
    '🎻',
    '🎹',
    '🎺',
    '🏖️',
    '🏝️',
    '🏜️',
    '🌋',
    '🚀',
    '🛸',
    '⚓',
    '🎡',
  ];

  List<ParticipantTrack> participantTracks = [];
  List<String> headerEmojis = [];
  EventsListener<RoomEvent> get _listener => widget.listener;
  bool get fastConnection => widget.room.engine.fastConnectOptions != null;

  Timer? _callTimer;
  int _callDurationSeconds = 0;
  bool _isEnteringPiP = false;

  StreamSubscription<RemoteMessage>? _fcmSubscription;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _setupFCMListener();

    // Generate unique emojis based on room name
    final seed =
        widget.room.name?.hashCode ?? DateTime.now().millisecondsSinceEpoch;
    final random = math.Random(seed);
    headerEmojis = List.generate(
      4,
      (_) => _emojiCandidates[random.nextInt(_emojiCandidates.length)],
    );

    widget.room.addListener(_onRoomDidUpdate);
    _setUpListeners();
    _sortParticipants();
    WidgetsBindingCompatible.instance?.addPostFrameCallback((_) {
      if (!fastConnection) {
        _askPublish();
      }
    });

    if (lkPlatformIs(PlatformType.android)) {
      unawaited(Hardware.instance.setSpeakerphoneOn(true));
    }

    if (lkPlatformIsDesktop()) {
      onWindowShouldClose = () async {
        unawaited(widget.room.disconnect());
        await _listener.waitFor<RoomDisconnectedEvent>(
          duration: const Duration(seconds: 5),
        );
      };
    }
  }

  @override
  void dispose() {
    _callTimer?.cancel();
    widget.room.removeListener(_onRoomDidUpdate);
    if (!_isEnteringPiP) {
      unawaited(_disposeRoomAsync());
    }
    onWindowShouldClose = null;
    super.dispose();
  }

  void _startTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _callDurationSeconds++;
        });
      }
    });
  }

  String get _formattedDuration {
    final minutes = (_callDurationSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_callDurationSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _disposeRoomAsync() async {
    await _listener.dispose();
    await widget.room.dispose();
  }

  Future<void> _activatePiP() async {
    setState(() {
      _isEnteringPiP = true;
    });

    final roomName = widget.room.name ?? 'Room';
    final participantName = widget.room.localParticipant?.name ?? 'Me';

    // Determine if video call (simplified logic)
    final isVideo =
        widget.room.remoteParticipants.values.any((p) => p.isCameraEnabled()) ||
        (widget.room.localParticipant?.isCameraEnabled() ?? false);

    final navigator = Navigator.of(context);

    ref
        .read(pipManagerProvider.notifier)
        .showPiP(
          context: context,
          roomName: roomName,
          participantName: participantName,
          isVideoCall: isVideo,
          chatId: null, // Assuming no chat ID available here or not needed
          room: widget.room,
          onExpand: () {
            // Re-push this page
            navigator.push(
              MaterialPageRoute(
                builder:
                    (_) => RoomPage(
                      widget.room,
                      widget.listener,
                      showVideoControl: widget.showVideoControl,
                    ),
              ),
            );
          },
          onClose: () {
            // Actually end call if closed from PiP
            unawaited(_disposeRoomAsync());
          },
        );

    // Pop this screen, but don't dispose room due to _isEnteringPiP flag
    navigator.pop();
  }

  void _setUpListeners() =>
      _listener
        ..on<RoomDisconnectedEvent>((event) async {
          if (event.reason != null) {
            if (kDebugMode) debugPrint('message here');
          }
          WidgetsBindingCompatible.instance?.addPostFrameCallback(
            (timeStamp) =>
                Navigator.popUntil(context, (route) => route.isFirst),
          );
          if (kDebugMode) debugPrint('message here');
          print("xoxochatId: ${widget.isGroup}");
          if (widget.chatId != "" && widget.isGroup == false) {
            EndCall(widget.chatId);
          }
        })
        ..on<ParticipantEvent>((event) {
          _sortParticipants();
        })
        ..on<RoomRecordingStatusChanged>((event) {
          unawaited(
            context.showRecordingStatusChangedDialog(event.activeRecording),
          );
        })
        ..on<RoomAttemptReconnectEvent>((event) {
          print(
            'Attempting to reconnect ${event.attempt}/${event.maxAttemptsRetry}, '
            '(${event.nextRetryDelaysInMs}ms delay until next attempt)',
          );
        })
        ..on<LocalTrackSubscribedEvent>((event) {
          print('Local track subscribed: ${event.trackSid}');
        })
        ..on<LocalTrackPublishedEvent>((_) => _sortParticipants())
        ..on<LocalTrackUnpublishedEvent>((_) => _sortParticipants())
        ..on<TrackSubscribedEvent>((_) => _sortParticipants())
        ..on<TrackUnsubscribedEvent>((_) => _sortParticipants())
        ..on<TrackE2EEStateEvent>(_onE2EEStateEvent)
        ..on<ParticipantNameUpdatedEvent>((event) {
          print(
            'Participant name updated: ${event.participant.identity}, name => ${event.name}',
          );
          _sortParticipants();
        })
        ..on<ParticipantMetadataUpdatedEvent>((event) {
          print(
            'Participant metadata updated: ${event.participant.identity}, metadata => ${event.metadata}',
          );
        })
        ..on<RoomMetadataChangedEvent>((event) {
          print('Room metadata changed: ${event.metadata}');

          // Check if metadata indicates call ended
          // try {
          //   if (event.metadata == null) return;
          //   final metadata = jsonDecode(event.metadata!);
          //   if (metadata['callStatus'] == 'ended' ||
          //       metadata['status'] == 'ended' ||
          //       metadata['callEnded'] == true) {
          //     // _endCallAndNavigateBack();
          //     // WidgetsBindingCompatible.instance?.addPostFrameCallback(
          //     //   (timeStamp) =>
          //     //       Navigator.popUntil(context, (route) => route.isFirst),
          //     // );
          //   }
          // } catch (e) {
          //   print('Error parsing metadata: $e');
          // }
        })
        ..on<DataReceivedEvent>((event) {
          String decoded = 'Failed to decode';
          try {
            decoded = utf8.decode(event.data);
          } catch (err) {
            print('Failed to decode: $err');
          }
          unawaited(context.showDataReceivedDialog(decoded));
        })
        ..on<AudioPlaybackStatusChanged>((event) async {
          if (!widget.room.canPlaybackAudio) {
            print('Audio playback failed for iOS Safari ..........');
            final yesno = await context.showPlayAudioManuallyDialog();
            if (yesno == true) {
              await widget.room.startAudio();
            }
          }
        });

  void _askPublish() async {
    final result = await context.showPublishDialog();
    if (!mounted) return;
    if (result != true) return;
    try {
      await widget.room.localParticipant?.setCameraEnabled(true);
    } catch (error) {
      print('could not publish video: $error');
      if (!mounted) return;
      await context.showErrorDialog(error);
    }
    try {
      await widget.room.localParticipant?.setMicrophoneEnabled(true);
    } catch (error) {
      print('could not publish audio: $error');
      if (!mounted) return;
      await context.showErrorDialog(error);
    }
  }

  void _onRoomDidUpdate() {
    _sortParticipants();
  }

  void _onE2EEStateEvent(TrackE2EEStateEvent e2eeState) {
    if (kDebugMode) debugPrint('message here');
  }

  void _sortParticipants() {
    final userMediaTracks = <ParticipantTrack>[];
    final screenTracks = <ParticipantTrack>[];
    for (var participant in widget.room.remoteParticipants.values) {
      for (var t in participant.videoTrackPublications) {
        if (t.isScreenShare) {
          screenTracks.add(
            ParticipantTrack(
              participant: participant,
              type: ParticipantTrackType.kScreenShare,
            ),
          );
        } else {
          userMediaTracks.add(ParticipantTrack(participant: participant));
        }
      }
    }

    userMediaTracks.sort((a, b) {
      if (a.participant.isSpeaking && b.participant.isSpeaking) {
        if (a.participant.audioLevel > b.participant.audioLevel) {
          return -1;
        } else {
          return 1;
        }
      }
      final aSpokeAt = a.participant.lastSpokeAt?.millisecondsSinceEpoch ?? 0;
      final bSpokeAt = b.participant.lastSpokeAt?.millisecondsSinceEpoch ?? 0;
      if (aSpokeAt != bSpokeAt) {
        return aSpokeAt > bSpokeAt ? -1 : 1;
      }
      if (a.participant.hasVideo != b.participant.hasVideo) {
        return a.participant.hasVideo ? -1 : 1;
      }
      return a.participant.joinedAt.millisecondsSinceEpoch -
          b.participant.joinedAt.millisecondsSinceEpoch;
    });

    final localParticipantTracks =
        widget.room.localParticipant?.videoTrackPublications;
    if (localParticipantTracks != null) {
      for (var t in localParticipantTracks) {
        if (t.isScreenShare) {
          screenTracks.add(
            ParticipantTrack(
              participant: widget.room.localParticipant!,
              type: ParticipantTrackType.kScreenShare,
            ),
          );
        } else {
          userMediaTracks.add(
            ParticipantTrack(participant: widget.room.localParticipant!),
          );
        }
      }
    }

    // Ensure local participant is in the list if no tracks yet (audio only)
    if (widget.room.localParticipant != null &&
        !userMediaTracks.any((p) => p.participant is LocalParticipant)) {
      userMediaTracks.add(
        ParticipantTrack(participant: widget.room.localParticipant!),
      );
    }

    setState(() {
      participantTracks = [...screenTracks, ...userMediaTracks];
    });
  }

  Future<void> EndCall(String chatId) async {
    final Dio dio = Dio();
    try {
      const secureStorage = FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock)
      );
      final accessToken = await secureStorage.read(key: 'access_token');

      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await dio.post('${base_url_dev}/chat/call/end/$chatId');

      if (response.statusCode == 201) {
        // Call ended successfully
      }
    } catch (e) {
      // Optional: log error
    }
  }

  void _setupFCMListener() {
    // Listen for FCM messages when app is in foreground
    _fcmSubscription = FirebaseMessaging.onMessage.listen((
      RemoteMessage message,
    ) {
      _handleFCMNotification(message);
    });

    // Also handle when app is in background/terminated (if needed)
    // This would typically be handled in your main.dart or a service
  }

  void _handleFCMNotification(RemoteMessage message) async {
    final data = message.data;
    final title = message.notification?.title ?? data['title'];
    final body = message.notification?.body ?? data['body'];
    final notificationType = data['type']; // Assuming you have a 'type' field

    if (kDebugMode) debugPrint('message here');
    if (kDebugMode) debugPrint('message here');
    if (widget.isGroup == true) return;

    // Check if this is a "Call Ended" notification
    if (title?.toLowerCase().contains('call ended') == true ||
        body?.toLowerCase().contains('call ended') == true ||
        notificationType == 'call_ended') {
      print('Call Ended notification received, ending call...');

      // End the call
      // _endCallFromNotification();
      // final result = await context.showDisconnectDialog();
      (widget.room.disconnect());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary, Color(0xFF0066FF)],
          ),
        ),
        child: Stack(
          children: [
            // Main Content Layer (Video/Grid/Avatar)
            Positioned.fill(child: _buildContent()),

            // Top Bar Layer
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.fullscreen_exit,
                        color: Colors.white,
                      ),
                      onPressed: _activatePiP,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: headerEmojis.map(_buildHeaderEmoji).toList(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person_add, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Controls Layer
            if (widget.room.localParticipant != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  top: false,
                  child: ControlsWidget(
                    widget.room,
                    widget.room.localParticipant!,
                    showVideoControl: widget.showVideoControl,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderEmoji(String emoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(emoji, style: const TextStyle(fontSize: 20)),
    );
  }

  // ...
  String? _focusedParticipantIdentity;
  Offset? _smallVideoPos;

  // ...

  Widget _buildContent() {
    final participants = participantTracks;
    if (participants.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    // If only one participant (e.g. just me), show single view
    if (participants.length == 1) {
      return _buildSingleParticipant(participants.first);
    }

    // Two person layout (Picture-in-Picture style within the app)
    if (participants.length == 2) {
      return _buildTwoPersonLayout(participants);
    }

    // Otherwise show grid (handles 3 or more)
    return _buildGrid(participants);
  }

  Widget _buildTwoPersonLayout(List<ParticipantTrack> participants) {
    // Default focus to the first remote participant if not set
    if (_focusedParticipantIdentity == null) {
      final remote = participants.firstWhereOrNull(
        (p) => p.participant is RemoteParticipant,
      );
      _focusedParticipantIdentity =
          remote?.participant.identity ??
          participants.first.participant.identity;
    }

    final focused = participants.firstWhere(
      (p) => p.participant.identity == _focusedParticipantIdentity,
      orElse: () => participants.first,
    );

    final other = participants.firstWhere(
      (p) => p.participant.identity != _focusedParticipantIdentity,
      orElse: () => participants.last,
    );

    // If for some reason they are the same (shouldn't happen with length 2 logic above unless duplicates),
    // fallback to grid.
    if (focused == other) return _buildGrid(participants);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Initialize position to bottom-right if null
        // We use a default margin of 16 from right and 120 from bottom (above controls)
        if (_smallVideoPos == null) {
          const double width = 100;
          const double height = 150;
          _smallVideoPos = Offset(
            constraints.maxWidth - width - 16,
            constraints.maxHeight - height - 120,
          );
        }

        return Stack(
          children: [
            // Full screen focused participant
            Positioned.fill(
              child: ParticipantWidget.widgetFor(focused, showStatsLayer: true),
            ),

            // Draggable small floating participant
            Positioned(
              left: _smallVideoPos!.dx,
              top: _smallVideoPos!.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _smallVideoPos = Offset(
                      (_smallVideoPos!.dx + details.delta.dx).clamp(
                        0.0,
                        constraints.maxWidth - 100,
                      ),
                      (_smallVideoPos!.dy + details.delta.dy).clamp(
                        0.0,
                        constraints.maxHeight - 150,
                      ),
                    );
                  });
                },
                onTap: () {
                  setState(() {
                    _focusedParticipantIdentity = other.participant.identity;
                  });
                },
                child: Container(
                  width: 100,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ParticipantWidget.widgetFor(
                      other,
                      showStatsLayer: false,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSingleParticipant(ParticipantTrack track) {
    final hasVideo = track.participant.videoTrackPublications.any(
      (t) => !t.muted,
    );

    // Check for audio track
    final audioPublication = track.participant.audioTrackPublications
        .firstWhereOrNull((t) => t.source == TrackSource.microphone);
    final audioTrack = audioPublication?.track;

    if (hasVideo) {
      // Full screen video
      return ParticipantWidget.widgetFor(track, showStatsLayer: true);
    } else {
      // Centered audio view
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              if (audioTrack is AudioTrack)
                SizedBox(
                  width: 300,
                  height: 100,
                  child: Center(
                    child: SoundWaveformWidget(
                      audioTrack: audioTrack,
                      barCount: 7,
                      width: 10,
                      minHeight: 40,
                      maxHeight: 120,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR90tjwut12dZIKgG8NUCZcKWUCA2H6WZ6Ukg&s',
                    ),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            track.participant.name.isNotEmpty
                ? track.participant.name
                : track.participant.identity,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_cellular_alt,
                color: Colors.white.withOpacity(0.8),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                _formattedDuration,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      );
    }
  }

  Widget _buildGrid(List<ParticipantTrack> tracks) {
    final count = tracks.length;
    int crossAxisCount;
    // double aspectRatio;

    if (count <= 4) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 3;
    }

    // Calculate aspect ratio dynamically to fit screen without scrolling
    // This is a rough approximation.
    // LayoutBuilder would be better but for now:
    // Assuming screen height available ~600-800px minus bars.

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight;
        final availableWidth = constraints.maxWidth;

        final rows = (count / crossAxisCount).ceil();
        final heightPerItem = (availableHeight / rows) - 10; // minus spacing
        final widthPerItem = (availableWidth / crossAxisCount) - 10;

        final ratio = widthPerItem / heightPerItem;

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: count,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: ratio,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.black26,
                  child: ParticipantWidget.widgetFor(tracks[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
