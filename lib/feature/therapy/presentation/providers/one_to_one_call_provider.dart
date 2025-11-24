import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
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
  EventsListener<RoomEvent>? _listener;

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
    state = state.copyWith(
      isConnecting: true,
      error: null,
      roomName: roomName,
      participantName: participantName,
      isVideoCall: isVideoCall,
      // Initialize UI state based on intent.
      // If it's a video call, we assume camera is ON until proven otherwise.
      isCameraOff: !isVideoCall,
      isMicMuted: false,
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

    final jwt = JWT({
      'iss': _apiKey,
      'exp': exp,
      'nbf': now,
      'sub': state.participantName,
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

      _room = Room();
      ref.read(liveKitRoomProvider.notifier).state = _room;

      // Create a listener to handle events more granularly
      _listener = _room!.createListener();
      _setUpRoomListeners();

      final token = _generateToken();

      final wantCamera = !state.isCameraOff && state.isVideoCall;

      await _room!
          .connect(
            _serverUrl,
            token,
            roomOptions: const RoomOptions(
              adaptiveStream: true,
              dynacast: true,
            ),
            fastConnectOptions: FastConnectOptions(
              microphone: TrackOption(enabled: !state.isMicMuted),
              camera: TrackOption(enabled: wantCamera),
            ),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception('Connection timeout');
            },
          );

      _localParticipant = _room!.localParticipant;

      // Initial sync of state after connection
      _syncStateWithLocalParticipant();

      state = state.copyWith(
        isConnected: true,
        isConnecting: false,
        isInCall: true,
      );

      _callStartTime = DateTime.now();
      _callDurationTimer?.cancel();
      _callDurationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        final duration = DateTime.now().difference(_callStartTime!);
        state = state.copyWith(callDuration: duration);
      });

      _updateParticipantTracks();
    } catch (e) {
      _cleanup();
      state = state.copyWith(
        isConnecting: false,
        isConnected: false,
        error: 'LiveKit connection failed: $e',
      );
    }
  }

  void _setUpRoomListeners() {
    if (_listener == null) return;

    // General room update for tracks
    _listener!
      ..on<RoomEvent>((_) => _onRoomUpdate())
      // Specific listeners to ensure button state stays in sync
      ..on<LocalTrackPublishedEvent>((e) => _onRoomUpdate())
      ..on<LocalTrackUnpublishedEvent>((e) => _onRoomUpdate())
      ..on<TrackMutedEvent>((e) => _onRoomUpdate())
      ..on<TrackUnmutedEvent>((e) => _onRoomUpdate());
  }

  void _onRoomUpdate() {
    if (!mounted) return;
    Future.microtask(() {
      if (mounted) {
        _updateParticipantTracks();
      }
    });
  }

  // Helper to sync CallState booleans with actual LocalParticipant object
  void _syncStateWithLocalParticipant() {
    if (_localParticipant == null) return;

    final isMicEnabled = _localParticipant!.isMicrophoneEnabled();
    final isCamEnabled = _localParticipant!.isCameraEnabled();

    // Only trigger a state update if the values are actually different
    // to prevent unnecessary rebuilds.
    if (state.isMicMuted == isMicEnabled || state.isCameraOff == isCamEnabled) {
      state = state.copyWith(
        isMicMuted: !isMicEnabled,
        isCameraOff: !isCamEnabled,
      );
    }
  }

  void _updateParticipantTracks() {
    if (_room == null || !mounted) return;

    try {
      // 1. Sync the button states (Fix for your issue)
      _syncStateWithLocalParticipant();

      // 2. Update the video tracks list
      final newTracks = <ParticipantTrack>[
        ..._room!.remoteParticipants.values.map(
          (p) => ParticipantTrack(
            participant: p,
            videoTrack:
                p.videoTrackPublications.isNotEmpty
                    ? p.videoTrackPublications.first.track as VideoTrack?
                    : null,
          ),
        ),
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

      final current = ref.read(participantTracksProvider);
      if (_shouldUpdateTracks(newTracks, current)) {
        ref.read(participantTracksProvider.notifier).state = newTracks;
      }
    } catch (_) {
      // Swallow to avoid UI crashes during rapid updates
    }
  }

  bool _shouldUpdateTracks(
    List<ParticipantTrack> next,
    List<ParticipantTrack> current,
  ) {
    if (next.length != current.length) return true;

    for (int i = 0; i < next.length; i++) {
      final a = next[i];
      final b = current[i];
      if (a.participant.sid != b.participant.sid) return true;

      final aMic = a.participant.isMicrophoneEnabled();
      final bMic = b.participant.isMicrophoneEnabled();
      if (aMic != bMic) return true;

      final aCam = a.participant.isCameraEnabled();
      final bCam = b.participant.isCameraEnabled();
      if (aCam != bCam) return true;

      final aHasVideo = a.videoTrack?.sid;
      final bHasVideo = b.videoTrack?.sid;
      if (aHasVideo != bHasVideo) return true;
    }
    return false;
  }

  Future<void> toggleMicrophone() async {
    if (_localParticipant == null) return;
    try {
      // Determine desired state based on current actual state, not just UI state
      final shouldEnable = !state.isMicMuted ? false : true;
      // Or better, trust the participant object:
      // final shouldEnable = !_localParticipant!.isMicrophoneEnabled();

      await _localParticipant!.setMicrophoneEnabled(shouldEnable);

      // We don't strictly need to set state here because _onRoomUpdate will catch it,
      // but setting it optimistically makes the UI feel snappier.
      state = state.copyWith(isMicMuted: !shouldEnable);
    } catch (_) {
      state = state.copyWith(error: 'Failed to toggle microphone');
    }
  }

  Future<void> toggleCamera() async {
    if (_localParticipant == null) return;
    try {
      final shouldEnable = state.isCameraOff ? true : false;
      await _localParticipant!.setCameraEnabled(shouldEnable);

      // Optimistic update
      state = state.copyWith(isCameraOff: !shouldEnable);
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
    await _cleanup();
  }

  Future<void> _cleanup() async {
    try {
      _listener?.dispose();
      _listener = null;

      if (_room != null) {
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
    _cleanup();
    super.dispose();
  }
}
