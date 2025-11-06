import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';
import '../providers/call_provider.dart';

class GroupCallScreen extends ConsumerStatefulWidget {
  final String? roomName;
  final String? participantName;
  final bool isVideoCall;

  const GroupCallScreen({
    super.key,
    this.roomName,
    this.participantName,
    this.isVideoCall = false,
  });

  @override
  ConsumerState<GroupCallScreen> createState() => _GroupCallScreenState();
}

class _GroupCallScreenState extends ConsumerState<GroupCallScreen> {
  @override
  void initState() {
    super.initState();
    // Delay startCall to avoid Riverpod lifecycle error
    Future(() => _startCall());
  }

  @override
  void dispose() {
    super.dispose();
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

    final words = name.trim().split(' ');
    return words.first;
  }

  @override
  Widget build(BuildContext context) {
    final callState = ref.watch(callControllerProvider);
    final participantTracks = ref.watch(participantTracksProvider);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(callState, participantTracks),
            Expanded(child: _buildMainContent(callState, participantTracks)),
            _buildControls(callState),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    CallState callState,
    List<ParticipantTrack> participantTracks,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              ref.read(callControllerProvider.notifier).endCall();
              Navigator.of(context).pop();
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  callState.roomName ?? 'Room',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  callState.isConnected
                      ? '${participantTracks.length} participant${participantTracks.length != 1 ? 's' : ''}'
                      : callState.isConnecting
                      ? 'Connecting...'
                      : 'Disconnected',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          // Add any additional header actions here if needed
          const SizedBox(width: 48), // Maintain layout balance
        ],
      ),
    );
  }

  Widget _buildMainContent(
    CallState callState,
    List<ParticipantTrack> participantTracks,
  ) {
    if (callState.isConnecting) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Connecting to call...',
              style: TextStyle(color: Colors.white, fontSize: 16),
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

    // Show content based on call type
    if (!callState.isVideoCall) {
      return _buildAudioCallView(participantTracks);
    }

    return _buildVideoCallView(participantTracks);
  }

  Widget _buildAudioCallView(List<ParticipantTrack> participantTracks) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.center,
            children:
                participantTracks
                    .map((track) => _buildParticipantAvatar(track))
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantAvatar(ParticipantTrack track) {
    final isLocal = track.participant is LocalParticipant;
    final isMuted = !track.participant.isMicrophoneEnabled();

    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Text(
                _getDisplayInitials(track.participant.name),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (isMuted)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.mic_off,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          isLocal ? 'You' : _getFirstName(track.participant.name),
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildVideoCallView(List<ParticipantTrack> participantTracks) {
    if (participantTracks.isEmpty) {
      return const Center(
        child: Text(
          'Waiting for participants...',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    final participantCount = participantTracks.length;

    // Google Meet-like adaptive grid layout
    int crossAxisCount;
    double aspectRatio;

    if (participantCount == 1) {
      crossAxisCount = 1;
      aspectRatio = 9 / 16;
    } else if (participantCount == 2) {
      crossAxisCount = 1;
      aspectRatio = 16 / 9;
    } else if (participantCount <= 4) {
      crossAxisCount = 2;
      aspectRatio = 4 / 3;
    } else if (participantCount <= 6) {
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
        itemCount: participantTracks.length,
        itemBuilder: (context, index) {
          final track = participantTracks[index];
          return _buildVideoTile(track);
        },
      ),
    );
  }

  Widget _buildVideoTile(ParticipantTrack track) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          if (track.videoTrack != null && track.participant.isCameraEnabled())
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox.expand(
                child: VideoTrackRenderer(
                  track.videoTrack!,
                  renderMode: VideoRenderMode.auto,
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
                    backgroundColor: Colors.blue.shade600,
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
                    _getFirstName(track.participant.name),
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

          // Participant info overlay (Google Meet style)
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
                  // Mic status icon
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

                  // Participant name
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

                  // Camera status for video calls
                  if (widget.isVideoCall) ...[
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
                ],
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
          // Microphone toggle
          _buildControlButton(
            icon: callState.isMicMuted ? Icons.mic_off : Icons.mic,
            isActive: !callState.isMicMuted,
            onPressed:
                () =>
                    ref
                        .read(callControllerProvider.notifier)
                        .toggleMicrophone(),
            backgroundColor: callState.isMicMuted ? Colors.red : null,
          ),

          // Camera toggle (only for video calls)
          if (callState.isVideoCall)
            _buildControlButton(
              icon: callState.isCameraOff ? Icons.videocam_off : Icons.videocam,
              isActive: !callState.isCameraOff,
              onPressed:
                  () =>
                      ref.read(callControllerProvider.notifier).toggleCamera(),
              backgroundColor: callState.isCameraOff ? Colors.red : null,
            ),

          // Speaker toggle
          _buildControlButton(
            icon: callState.isSpeakerOn ? Icons.volume_up : Icons.volume_down,
            isActive: callState.isSpeakerOn,
            onPressed:
                () => ref.read(callControllerProvider.notifier).toggleSpeaker(),
            backgroundColor: callState.isSpeakerOn ? Colors.blue : null,
          ),

          // End call
          _buildControlButton(
            icon: Icons.call_end,
            onPressed: () {
              ref.read(callControllerProvider.notifier).endCall();
              Navigator.of(context).pop();
            },
            backgroundColor: Colors.red,
            isDestructive: true,
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
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? (isActive ? Colors.white24 : Colors.white12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color:
              isDestructive
                  ? Colors.white
                  : (isActive ? Colors.white : Colors.white60),
          size: 28,
        ),
        iconSize: 28,
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}
