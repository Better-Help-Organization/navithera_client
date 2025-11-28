import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:navithera_client/core/theme/app_colors.dart';

import '../exts.dart';
import '../utils.dart';
import '../widgets/controls.dart';
import '../widgets/participant.dart';
import '../widgets/participant_info.dart';
import '../widgets/sound_waveform.dart';


class RoomPage extends StatefulWidget {
  final Room room;
  final EventsListener<RoomEvent> listener;

  const RoomPage(
    this.room,
    this.listener, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  static const _emojiCandidates = [
    '🎨', '📡', '🇮🇹', '💂', '🦁', '🐯', '🎱', '🎲', 
    '🎸', '🎻', '🎹', '🎺', '🏖️', '🏝️', '🏜️', '🌋', 
    '🚀', '🛸', '⚓', '🎡'
  ];

  List<ParticipantTrack> participantTracks = [];
  List<String> headerEmojis = [];
  EventsListener<RoomEvent> get _listener => widget.listener;
  bool get fastConnection => widget.room.engine.fastConnectOptions != null;
  
  Timer? _callTimer;
  int _callDurationSeconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
    
    // Generate unique emojis based on room name
    final seed = widget.room.name?.hashCode ?? DateTime.now().millisecondsSinceEpoch;
    final random = math.Random(seed);
    headerEmojis = List.generate(4, (_) => _emojiCandidates[random.nextInt(_emojiCandidates.length)]);

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
        await _listener.waitFor<RoomDisconnectedEvent>(duration: const Duration(seconds: 5));
      };
    }
  }

  @override
  void dispose() {
    _callTimer?.cancel();
    widget.room.removeListener(_onRoomDidUpdate);
    unawaited(_disposeRoomAsync());
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

  void _setUpListeners() => _listener
    ..on<RoomDisconnectedEvent>((event) async {
      if (event.reason != null) {
        print('Room disconnected: reason => ${event.reason}');
      }
      WidgetsBindingCompatible.instance
          ?.addPostFrameCallback((timeStamp) => Navigator.popUntil(context, (route) => route.isFirst));
    })
    ..on<ParticipantEvent>((event) {
      _sortParticipants();
    })
    ..on<RoomRecordingStatusChanged>((event) {
      unawaited(context.showRecordingStatusChangedDialog(event.activeRecording));
    })
    ..on<RoomAttemptReconnectEvent>((event) {
      print('Attempting to reconnect ${event.attempt}/${event.maxAttemptsRetry}, '
          '(${event.nextRetryDelaysInMs}ms delay until next attempt)');
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
      print('Participant name updated: ${event.participant.identity}, name => ${event.name}');
      _sortParticipants();
    })
    ..on<ParticipantMetadataUpdatedEvent>((event) {
      print('Participant metadata updated: ${event.participant.identity}, metadata => ${event.metadata}');
    })
    ..on<RoomMetadataChangedEvent>((event) {
      print('Room metadata changed: ${event.metadata}');
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
    print('e2ee state: $e2eeState');
  }

  void _sortParticipants() {
    final userMediaTracks = <ParticipantTrack>[];
    final screenTracks = <ParticipantTrack>[];
    for (var participant in widget.room.remoteParticipants.values) {
      for (var t in participant.videoTrackPublications) {
        if (t.isScreenShare) {
          screenTracks.add(ParticipantTrack(
            participant: participant,
            type: ParticipantTrackType.kScreenShare,
          ));
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
      return a.participant.joinedAt.millisecondsSinceEpoch - b.participant.joinedAt.millisecondsSinceEpoch;
    });

    final localParticipantTracks = widget.room.localParticipant?.videoTrackPublications;
    if (localParticipantTracks != null) {
      for (var t in localParticipantTracks) {
        if (t.isScreenShare) {
          screenTracks.add(ParticipantTrack(
            participant: widget.room.localParticipant!,
            type: ParticipantTrackType.kScreenShare,
          ));
        } else {
          userMediaTracks.add(ParticipantTrack(participant: widget.room.localParticipant!));
        }
      }
    }
    
    // Ensure local participant is in the list if no tracks yet (audio only)
    if (widget.room.localParticipant != null && 
        !userMediaTracks.any((p) => p.participant is LocalParticipant)) {
       userMediaTracks.add(ParticipantTrack(participant: widget.room.localParticipant!));
    }

    setState(() {
      participantTracks = [...screenTracks, ...userMediaTracks];
    });
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
            colors: [
              AppColors.primary, 
              Color(0xFF0066FF),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Main Content Layer (Video/Grid/Avatar)
            Positioned.fill(
              child: _buildContent(),
            ),

            // Top Bar Layer
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.fullscreen_exit, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
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
                  child: ControlsWidget(widget.room, widget.room.localParticipant!),
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

  Widget _buildContent() {
    final participants = participantTracks;
    if (participants.isEmpty) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }
    
    final remoteParticipants = participants.where((p) => p.participant is RemoteParticipant).toList();
    
    if (remoteParticipants.isEmpty) {
       // Only local
       return _buildSingleParticipant(participants.first);
    } else if (remoteParticipants.length == 1) {
       // 1-on-1 call
       return _buildSingleParticipant(remoteParticipants.first);
    } else {
       // Group call
       return _buildGrid(participants);
    }
  }

  Widget _buildSingleParticipant(ParticipantTrack track) {
    final hasVideo = track.participant.videoTrackPublications.any((t) => !t.muted);
    
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
                      image: NetworkImage('https://i.pravatar.cc/300'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Colors.white.withOpacity(0.2), width: 0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      )
                    ]
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              track.participant.name.isNotEmpty ? track.participant.name : track.participant.identity,
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
                 Icon(Icons.signal_cellular_alt, color: Colors.white.withOpacity(0.8), size: 16),
                 const SizedBox(width: 8),
                 Text(
                   _formattedDuration, 
                   style: TextStyle(
                     color: Colors.white.withOpacity(0.8),
                     fontSize: 16,
                   ),
                 ),
              ],
            )
         ],
       );
    }
  }

  Widget _buildGrid(List<ParticipantTrack> tracks) {
    final count = tracks.length;
    int crossAxisCount;
    double aspectRatio;

    if (count <= 2) {
      crossAxisCount = 1;
      aspectRatio = 0.8; 
    } else if (count <= 4) {
      crossAxisCount = 2;
      aspectRatio = 0.75;
    } else {
      crossAxisCount = 3;
      aspectRatio = 1.0;
    }

    // Add padding to avoid overlap with top bar and bottom controls
    return Padding(
      padding: EdgeInsets.zero,
      child: GridView.builder(
        itemCount: count,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: aspectRatio,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.black26,
              child: ParticipantWidget.widgetFor(tracks[index]),
            ),
          );
        },
      ),
    );
  }
}
