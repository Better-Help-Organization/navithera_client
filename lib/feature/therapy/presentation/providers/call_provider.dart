import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:navithera_client/feature/auth/presentation/providers/user_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// LiveKit room provider
final liveKitRoomProvider = StateProvider<Room?>((ref) => null);

// Call state provider
final callControllerProvider = StateNotifierProvider<CallController, CallState>(
  (ref) {
    return CallController(ref);
  },
);

// Participant tracks provider
final participantTracksProvider = StateProvider<List<ParticipantTrack>>(
  (ref) => [],
);

class CallState {
  final bool isInCall;
  final bool isConnecting;
  final bool isConnected;
  final String? error;

  // Control states
  final bool isMicMuted;
  final bool isCameraOff;
  final bool isSpeakerOn;

  // Room info
  final String? roomName;
  final String? participantName;
  final bool isVideoCall;

  final Duration callDuration;

  const CallState({
    this.isInCall = false,
    this.isConnecting = false,
    this.isConnected = false,
    this.error,
    this.isMicMuted = false,
    this.isCameraOff = false,
    this.isSpeakerOn = false,
    this.roomName,
    this.participantName,
    this.isVideoCall = false,
    this.callDuration = Duration.zero,
  });

  CallState copyWith({
    bool? isInCall,
    bool? isConnecting,
    bool? isConnected,
    String? error,
    bool? isMicMuted,
    bool? isCameraOff,
    bool? isSpeakerOn,
    String? roomName,
    String? participantName,
    bool? isVideoCall,
    Duration? callDuration,
  }) {
    return CallState(
      isInCall: isInCall ?? this.isInCall,
      isConnecting: isConnecting ?? this.isConnecting,
      isConnected: isConnected ?? this.isConnected,
      error: error ?? this.error,
      isMicMuted: isMicMuted ?? this.isMicMuted,
      isCameraOff: isCameraOff ?? this.isCameraOff,
      isSpeakerOn: isSpeakerOn ?? this.isSpeakerOn,
      roomName: roomName ?? this.roomName,
      participantName: participantName ?? this.participantName,
      isVideoCall: isVideoCall ?? this.isVideoCall,
      callDuration: callDuration ?? this.callDuration,
    );
  }
}

class ParticipantTrack {
  final Participant participant;
  final VideoTrack? videoTrack;
  final bool isScreenShare;

  ParticipantTrack({
    required this.participant,
    this.videoTrack,
    this.isScreenShare = false,
  });
}

class CallController extends StateNotifier<CallState> {
  final Ref ref;
  Room? _room;
  LocalParticipant? _localParticipant;
  Timer? _callDurationTimer;
  DateTime? _callStartTime;
  EventsListener<RoomEvent>? _roomListener;
  bool _eventListenersSetup = false;

  // LiveKit credentials
  static const String _serverUrl = 'wss://navicare-dmw0dh3w.livekit.cloud';
  static const String _apiKey = 'API3tXd9NPdnoo6';
  static const String _apiSecret =
      'NviAjniG1zqEKxIlkKAFU3b895WALQlyE5zmafHNTRA';

  CallController(this.ref) : super(const CallState());

  Future<void> startCall({
    required String roomName,
    required String participantName,
    required bool isVideoCall,
  }) async {
    // Initialize state with user intent.
    // If isVideoCall is true, isCameraOff is false.
    state = state.copyWith(
      isConnecting: true,
      error: null,
      roomName: roomName,
      participantName: participantName,
      isVideoCall: isVideoCall,
      isCameraOff: !isVideoCall,
      isMicMuted: false, // Default mic to on
    );

    try {
      await _checkPermissions(needsCamera: isVideoCall);
      await _connectToRoom();
    } catch (e) {
      state = state.copyWith(
        isConnecting: false,
        isConnected: false,
        error: 'Failed to start call: ${e.toString()}',
      );
    }
  }

  Future<void> _checkPermissions({required bool needsCamera}) async {
    try {
      final micStatus = await Permission.microphone.request();
      if (micStatus.isDenied || micStatus.isPermanentlyDenied) {
        throw Exception('Microphone permission is required for calls');
      }
      if (needsCamera) {
        final cameraStatus = await Permission.camera.request();
        if (cameraStatus.isDenied || cameraStatus.isPermanentlyDenied) {
          throw Exception('Camera permission is required for video calls');
        }
      }
    } catch (e) {
      throw Exception('Failed to get required permissions: $e');
    }
  }

  String _generateToken() {
    if (state.roomName == null || state.roomName!.isEmpty) {
      throw Exception('Room name is required for token generation');
    }
    if (state.participantName == null || state.participantName!.isEmpty) {
      throw Exception('Participant name is required for token generation');
    }

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final exp = now + (24 * 60 * 60);

    final user = ref.watch(currentUserProvider);

    final jwt = JWT({
      'iss': _apiKey,
      'exp': exp,
      'nbf': now,
      'sub': state.participantName,
      'name': "${user?.firstName ?? ''} ${user?.lastName ?? ''}".trim(),
      'video': {
        'room': state.roomName,
        'roomJoin': true,
        'canPublish': true,
        'canSubscribe': true,
      },
    });

    try {
      return jwt.sign(SecretKey(_apiSecret));
    } catch (e) {
      throw Exception('Failed to generate access token: $e');
    }
  }

  Future<void> _connectToRoom() async {
    try {
      if (_serverUrl.isEmpty || _apiKey.isEmpty || _apiSecret.isEmpty) {
        throw Exception('LiveKit credentials are not properly configured');
      }
      if (!_serverUrl.startsWith('ws://') && !_serverUrl.startsWith('wss://')) {
        throw Exception('Invalid LiveKit server URL: $_serverUrl');
      }

      _room = Room();
      ref.read(liveKitRoomProvider.notifier).state = _room;

      _room!.addListener(_onRoomUpdate);

      final token = _generateToken();

      // We use the state we set in startCall() to determine connection options
      final wantCamera = !state.isCameraOff;
      final wantMic = !state.isMicMuted;

      await _room!
          .connect(
            _serverUrl,
            token,
            roomOptions: const RoomOptions(
              adaptiveStream: true,
              dynacast: true,
            ),
            fastConnectOptions: FastConnectOptions(
              microphone: TrackOption(enabled: wantMic),
              camera: TrackOption(enabled: wantCamera),
            ),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception(
                'Connection timeout: Could not connect to LiveKit server within 30 seconds',
              );
            },
          );

      _localParticipant = _room!.localParticipant;

      // FIX: Previously, we checked _localParticipant!.isCameraEnabled() here.
      // That caused the bug because the track is still publishing asynchronously
      // when connect() returns, so isCameraEnabled() reports false temporarily.
      //
      // Instead, we trust the 'wantCamera' intent we just passed to FastConnectOptions.
      // If the hardware actually fails later, the error handling or event listeners will catch it.

      state = state.copyWith(
        isConnected: true,
        isConnecting: false,
        isInCall: true,
        // We DO NOT overwrite isCameraOff or isMicMuted here.
        // We keep the values set in startCall().
      );

      _callStartTime = DateTime.now();
      _callDurationTimer?.cancel();
      _callDurationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        final duration = DateTime.now().difference(_callStartTime!);
        state = state.copyWith(callDuration: duration);
      });

      _updateParticipantTracks();
    } catch (e) {
      if (_room != null) {
        try {
          _room!.removeListener(_onRoomUpdate);
          _roomListener?.dispose();
          _roomListener = null;
          _eventListenersSetup = false;
          await _room!.disconnect();
          _room!.dispose();
        } catch (_) {}
        _room = null;
      }
      ref.read(liveKitRoomProvider.notifier).state = null;

      throw Exception('LiveKit connection failed: $e');
    }
  }

  void _onRoomUpdate() {
    if (!mounted) return;

    if (!_eventListenersSetup && _room != null && state.isConnected) {
      _eventListenersSetup = true;
      _roomListener =
          _room!.createListener()
            ..on<TrackPublishedEvent>((event) {
              _updateParticipantTracks();
            })
            ..on<TrackUnpublishedEvent>((event) {
              _updateParticipantTracks();
            })
            ..on<TrackMutedEvent>((event) {
              _updateParticipantTracks();
              // Optional: Sync button state if muted remotely or by system
              if (event.participant == _localParticipant) {
                _syncLocalState();
              }
            })
            ..on<TrackUnmutedEvent>((event) {
              _updateParticipantTracks();
              // Optional: Sync button state
              if (event.participant == _localParticipant) {
                _syncLocalState();
              }
            })
            ..on<ParticipantConnectedEvent>((event) {
              _updateParticipantTracks();
            })
            ..on<ParticipantDisconnectedEvent>((event) {
              _updateParticipantTracks();
            });
    }

    Future.microtask(() {
      if (mounted) {
        _updateParticipantTracks();
      }
    });
  }

  // Helper to sync state if events happen outside our button clicks
  void _syncLocalState() {
    if (_localParticipant == null) return;
    // We only sync if we are sure the tracks are established
    state = state.copyWith(
      isMicMuted: !_localParticipant!.isMicrophoneEnabled(),
      isCameraOff: !_localParticipant!.isCameraEnabled(),
    );
  }

  void _updateParticipantTracks() {
    if (_room == null || !mounted) return;

    try {
      final newTracks = <ParticipantTrack>[
        ..._room!.remoteParticipants.values.map((p) {
          VideoTrack? targetTrack;
          // Prioritize camera, fallback to screen share or first available
          final cameraPub = p.videoTrackPublications.firstWhere(
            (pub) => pub.source == TrackSource.camera,
            orElse:
                () =>
                    p.videoTrackPublications.isNotEmpty
                        ? p.videoTrackPublications.first
                        : throw 'No tracks',
          );

          // Safe cast check
          if (cameraPub.track != null) {
            targetTrack = cameraPub.track as VideoTrack?;
          }

          return ParticipantTrack(participant: p, videoTrack: targetTrack);
        }),
        if (_localParticipant != null)
          ParticipantTrack(
            participant: _localParticipant!,
            videoTrack:
                _localParticipant!.videoTrackPublications.isNotEmpty
                    ? _localParticipant!.videoTrackPublications.first.track
                        as VideoTrack?
                    : null,
          ),
      ];

      ref.read(participantTracksProvider.notifier).state = newTracks;
    } catch (_) {
      // Handle cases where tracks might be empty during connection
    }
  }

  Future<void> toggleMicrophone() async {
    if (_localParticipant == null) return;
    try {
      final newMicState = state.isMicMuted; // Current state (true = muted)
      // We want to set enabled to !newMicState (if muted, enable it)
      await _localParticipant!.setMicrophoneEnabled(newMicState);
      state = state.copyWith(isMicMuted: !newMicState);
    } catch (_) {
      state = state.copyWith(error: 'Failed to toggle microphone');
    }
  }

  Future<void> toggleCamera() async {
    if (_localParticipant == null) return;
    try {
      final newCameraState = state.isCameraOff; // Current state (true = off)
      // We want to set enabled to !newCameraState (if off, enable it)
      await _localParticipant!.setCameraEnabled(newCameraState);
      state = state.copyWith(isCameraOff: !newCameraState);
    } catch (_) {
      state = state.copyWith(error: 'Failed to toggle camera');
    }
  }

  Future<void> toggleSpeaker() async {
    try {
      final newSpeakerState = !state.isSpeakerOn;
      await Hardware.instance.setSpeakerphoneOn(newSpeakerState);
      state = state.copyWith(isSpeakerOn: newSpeakerState);
    } catch (_) {
      state = state.copyWith(error: 'Failed to toggle speaker');
    }
  }

  Future<void> endCall() async {
    try {
      if (_room != null) {
        _room!.removeListener(_onRoomUpdate);
        _roomListener?.dispose();
        _roomListener = null;
        _eventListenersSetup = false;
        await _room!.disconnect();
        _room!.dispose();
        _room = null;
      }

      _callDurationTimer?.cancel();
      _callDurationTimer = null;

      ref.read(liveKitRoomProvider.notifier).state = null;
      ref.read(participantTracksProvider.notifier).state = [];

      state = const CallState();
    } catch (_) {
      // ignore
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  @override
  void dispose() {
    unawaited(endCall());
    super.dispose();
  }
}
