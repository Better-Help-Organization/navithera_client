import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:navithera_client/core/constants/emoji_list.dart';
import 'package:navithera_client/core/util/format_duration.dart';
import '../providers/call_provider.dart';

class PiPCallWidget extends ConsumerStatefulWidget {
  final String? roomName;
  final String? participantName;
  final bool isVideoCall;
  final String? chatId;
  final VoidCallback? onExpand;
  final VoidCallback? onClose;
  final Room? room;

  const PiPCallWidget({
    super.key,
    this.roomName,
    this.participantName,
    this.isVideoCall = false,
    this.chatId,
    this.onExpand,
    this.onClose,
    this.room,
  });

  @override
  ConsumerState<PiPCallWidget> createState() => _PiPCallWidgetState();
}

class _PiPCallWidgetState extends ConsumerState<PiPCallWidget>
    with TickerProviderStateMixin {
  Offset _position = const Offset(20, 100);
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  Timer? _callTimer;
  Duration _callDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);

    // Start call duration timer
    _startCallTimer();
  }

  void _startCallTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _callDuration = _callDuration + const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _callTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final callState = ref.watch(callControllerProvider);
    final screenSize = MediaQuery.of(context).size;

    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _position = Offset(
              (_position.dx + details.delta.dx).clamp(
                0.0,
                screenSize.width - 120,
              ),
              (_position.dy + details.delta.dy).clamp(
                0.0,
                screenSize.height - 160,
              ),
            );
          });
        },
        // Remove onTap to prevent accidental expansion
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: Container(
                width: 150,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF7EB09B), Color(0xFF4A90E2)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Video feed or avatar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: _buildVideoContent(callState),
                    ),

                    // Top bar with expand button
                    Positioned(
                      top: 8,
                      left: 8,
                      child: GestureDetector(
                        onTap: widget.onExpand,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            //color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.open_in_full,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),

                    // Bottom info bar
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Mic Icon
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(callControllerProvider.notifier)
                                    .toggleMicrophone();
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color:
                                      !callState.isMicMuted
                                          ? Colors.green.withOpacity(0.8)
                                          : Colors.red.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  !callState.isMicMuted
                                      ? Icons.mic
                                      : Icons.mic_off,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Room emojis
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      _getRoomEmojis(
                                            widget.roomName ?? 'default-room',
                                          )
                                          .take(3)
                                          .map(
                                            (emoji) => Text(
                                              emoji,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                ),
                                const SizedBox(height: 2),
                                // Call duration
                                // Text(
                                //   formatDuration(_callDuration),
                                //   style: const TextStyle(
                                //     color: Colors.white,
                                //     fontSize: 10,
                                //     fontWeight: FontWeight.w500,
                                //   ),
                                // ),
                              ],
                            ),

                            // End call Icon
                            GestureDetector(
                              onTap: widget.onClose,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.call_end,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVideoContent(CallState callState) {
    // Handle explicit room object
    if (widget.room != null) {
      final room = widget.room!;
      final remoteParticipants = room.remoteParticipants.values;
      
      // Try to find a remote participant with video
      for (var p in remoteParticipants) {
        final videoTrackPub = p.videoTrackPublications.firstWhereOrNull((t) => !t.muted);
        if (videoTrackPub != null && videoTrackPub.track != null) {
             return VideoTrackRenderer(
              videoTrackPub.track!,
              fit: VideoViewFit.cover,
            );
        }
      }
      
      // If no remote video, maybe local video?
      // Or just fallthrough to avatar.
    }

    // Get participant tracks from the provider
    final participantTracks = ref.watch(participantTracksProvider);

    if (widget.isVideoCall && participantTracks.isNotEmpty) {
      // Show remote participant's video
      final remoteTrack = participantTracks.firstWhere(
        (track) => track.participant.identity != callState.participantName,
        orElse: () => participantTracks.first,
      );

      if (remoteTrack.videoTrack != null) {
        return VideoTrackRenderer(
          remoteTrack.videoTrack!,
          fit: VideoViewFit.cover,
        );
      }
    }

    // Fallback: Show participant avatar/initials
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF7EB09B).withOpacity(0.8),
            const Color(0xFF4A90E2).withOpacity(0.8),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white.withOpacity(0.2),
              child: Text(
                _getInitials(widget.participantName ?? 'User'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.participantName ?? 'Unknown',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'U';

    final parts = trimmed.split(' ');
    if (parts.length >= 2) {
      final first = parts[0];
      final second = parts[1];
      if (first.isNotEmpty && second.isNotEmpty) {
        return '${first[0]}${second[0]}'.toUpperCase();
      }
    }
    
    if (parts.isNotEmpty) {
      final first = parts[0];
      if (first.isNotEmpty) {
        return first[0].toUpperCase();
      }
    }
    return 'U';
  }

  List<String> _getRoomEmojis(String roomName) {
    return roomNameToEmojis(roomName);
  }

  List<String> roomNameToEmojis(String roomName, {int emojiCount = 4}) {
    final hash = roomName.codeUnits.fold(0, (a, b) => a + b);
    final emojis = <String>[];
    for (int i = 0; i < emojiCount; i++) {
      final index = (hash + i) % emojiList.length;
      emojis.add(emojiList[index]);
    }
    return emojis;
  }
}
