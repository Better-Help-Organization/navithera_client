// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:livekit_client/livekit_client.dart';
// import 'package:navithera_client/core/constants/base_url.dart';
// import 'package:navithera_client/core/util/format_duration.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class GroupCallScreen extends ConsumerStatefulWidget {
//   final String roomName;
//   final String participantName;
//   final bool isVideoCall;
//   final String? chatId;

//   const GroupCallScreen({
//     super.key,
//     required this.roomName,
//     required this.participantName,
//     required this.isVideoCall,
//     this.chatId,
//   });

//   @override
//   ConsumerState<GroupCallScreen> createState() => _GroupCallScreenState();
// }

// class _GroupCallScreenState extends ConsumerState<GroupCallScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(_joinCall);
//   }

//   Future<void> _joinCall() async {
//     await ref
//         .read(groupCallControllerProvider.notifier)
//         .joinGroupCall(
//           roomName: widget.roomName,
//           participantName: widget.participantName,
//           isVideoCall: widget.isVideoCall,
//         );
//   }

//   Future<void> _endCall() async {
//     if (widget.chatId != null) {
//       await _sendEndCallNotification(chatId: widget.chatId!);
//     }
//     await ref.read(groupCallControllerProvider.notifier).leaveCall();
//     if (mounted) {
//       Navigator.of(context).pop();
//     }
//   }

//   Future<void> _sendEndCallNotification({required String chatId}) async {
//     final Dio dio = Dio();
//     try {
//       final sharedPreferences = await SharedPreferences.getInstance();
//       final accessToken = sharedPreferences.getString('access_token');

//       dio.options.headers['Authorization'] = 'Bearer $accessToken';
//       await dio.post('${base_url_dev}/chat/call/end/$chatId');
//     } catch (e) {
//       // Optional: log error
//     }
//   }

//   String _getDisplayInitials(String name) {
//     if (name.isEmpty) return '?';
//     final words = name.trim().split(' ');
//     if (words.length >= 2) {
//       return '${words.first[0].toUpperCase()}${words.last[0].toUpperCase()}';
//     } else {
//       return name.length >= 2
//           ? '${name[0].toUpperCase()}${name[1].toUpperCase()}'
//           : name[0].toUpperCase();
//     }
//   }

//   String _getFirstName(String name) {
//     if (name.isEmpty) return 'Unknown';
//     return name.trim().split(' ').first;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final callState = ref.watch(groupCallControllerProvider);
//     final allParticipants = [
//       if (callState.isConnected) ...callState.remoteParticipants,
//     ];

//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         backgroundColor: Colors.grey[900],
//         body: SafeArea(
//           child: Column(
//             children: [
//               // Header
//               _buildHeader(callState),

//               // Main content
//               Expanded(child: _buildMainContent(callState, allParticipants)),

//               // Controls
//               _buildControls(callState),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(GroupCallState callState) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Call duration and participant count
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 formatDuration(callState.callDuration),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 '${callState.remoteParticipants.length + 1} people in call',
//                 style: const TextStyle(color: Colors.white70, fontSize: 14),
//               ),
//             ],
//           ),

//           // Room name
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.5),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               widget.roomName,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),

//           // Minimize button (optional - for PiP)
//           IconButton(
//             onPressed: () {
//               // Implement PiP or minimize functionality
//             },
//             icon: const Icon(Icons.minimize, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMainContent(
//     GroupCallState callState,
//     List<RemoteParticipant> participants,
//   ) {
//     if (callState.isConnecting) {
//       return _buildConnectingView();
//     }

//     if (callState.error != null) {
//       return _buildErrorView(callState.error!);
//     }

//     if (!callState.isConnected) {
//       return _buildDisconnectedView();
//     }

//     // Show grid of participants
//     return _buildParticipantsGrid(participants, callState);
//   }

//   Widget _buildConnectingView() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const CircularProgressIndicator(color: Colors.white),
//           const SizedBox(height: 20),
//           Text(
//             'Joining ${widget.roomName}',
//             style: const TextStyle(color: Colors.white, fontSize: 18),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'Please wait...',
//             style: TextStyle(color: Colors.white70, fontSize: 14),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorView(String error) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.error_outline, color: Colors.red, size: 64),
//             const SizedBox(height: 20),
//             Text(
//               'Connection Error',
//               style: const TextStyle(color: Colors.white, fontSize: 20),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               error,
//               style: const TextStyle(color: Colors.white70, fontSize: 14),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 ref.read(groupCallControllerProvider.notifier).clearError();
//                 _joinCall();
//               },
//               child: const Text('Try Again'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDisconnectedView() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.call_end, color: Colors.red, size: 64),
//           const SizedBox(height: 20),
//           const Text(
//             'Call Ended',
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//           const SizedBox(height: 12),
//           const Text(
//             'You have left the meeting',
//             style: TextStyle(color: Colors.white70, fontSize: 14),
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildParticipantsGrid(
//     List<RemoteParticipant> participants,
//     GroupCallState callState,
//   ) {
//     // Include local participant in the grid
//     final allParticipants = [
//       _LocalParticipantWrapper(callState: callState),
//       ...participants,
//     ];

//     final participantCount = allParticipants.length;
//     int crossAxisCount;
//     double aspectRatio;

//     if (participantCount == 1) {
//       crossAxisCount = 1;
//       aspectRatio = 16 / 9;
//     } else if (participantCount <= 4) {
//       crossAxisCount = 2;
//       aspectRatio = 4 / 3;
//     } else if (participantCount <= 6) {
//       crossAxisCount = 2;
//       aspectRatio = 1;
//     } else if (participantCount <= 9) {
//       crossAxisCount = 3;
//       aspectRatio = 1;
//     } else {
//       crossAxisCount = 4;
//       aspectRatio = 1;
//     }

//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: crossAxisCount,
//           childAspectRatio: aspectRatio,
//           crossAxisSpacing: 8,
//           mainAxisSpacing: 8,
//         ),
//         itemCount: allParticipants.length,
//         itemBuilder: (context, index) {
//           final participant = allParticipants[index];
//           return _buildParticipantTile(participant);
//         },
//       ),
//     );
//   }

//   Widget _buildParticipantTile(dynamic participant) {
//     final isLocal = participant is _LocalParticipantWrapper;
//     final name = isLocal ? 'You' : _getFirstName(participant.name);

//     final initials =
//         isLocal
//             ? _getDisplayInitials(widget.participantName)
//             : _getDisplayInitials(participant.name);

//     final hasVideo =
//         isLocal
//             ? !participant.callState.isCameraOff &&
//                 participant.callState.isVideoCall
//             : participant.isCameraEnabled();

//     final isMuted =
//         isLocal
//             ? participant.callState.isMicMuted
//             : !participant.isMicrophoneEnabled();

//     // Get video track for remote participants
//     VideoTrack? videoTrack;
//     if (!isLocal) {
//       final videoPublications = participant.videoTrackPublications;
//       if (videoPublications.isNotEmpty) {
//         videoTrack = videoPublications.first.track as VideoTrack?;
//       }
//     }

//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: Colors.black.withOpacity(0.3),
//       ),
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Video or avatar background
//           if (hasVideo && videoTrack != null && !isLocal)
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: VideoTrackRenderer(
//                 videoTrack,
//                 fit: VideoViewFit.cover,
//                 renderMode: VideoRenderMode.auto,
//               ),
//             )
//           else if (isLocal && hasVideo)
//             // Local video would be handled differently in real implementation
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.blue[800],
//               ),
//               child: Center(
//                 child: Text(
//                   initials,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             )
//           else
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.blue[800],
//               ),
//               child: Center(
//                 child: Text(
//                   initials,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),

//           // Participant info overlay
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                   colors: [Colors.black.withOpacity(0.8), Colors.transparent],
//                 ),
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(8),
//                   bottomRight: Radius.circular(8),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     isMuted ? Icons.mic_off : Icons.mic,
//                     color: isMuted ? Colors.red : Colors.white,
//                     size: 12,
//                   ),
//                   const SizedBox(width: 6),
//                   Expanded(
//                     child: Text(
//                       name,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   if (hasVideo)
//                     const Icon(Icons.videocam, color: Colors.white, size: 12)
//                   else
//                     const Icon(Icons.videocam_off, color: Colors.red, size: 12),
//                 ],
//               ),
//             ),
//           ),

//           // You badge for local participant
//           if (isLocal)
//             Positioned(
//               top: 8,
//               left: 8,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: const Text(
//                   'You',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildControls(GroupCallState callState) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildControlButton(
//             icon: callState.isMicMuted ? Icons.mic_off : Icons.mic,
//             isActive: !callState.isMicMuted,
//             onPressed:
//                 () =>
//                     ref
//                         .read(groupCallControllerProvider.notifier)
//                         .toggleMicrophone(),
//             backgroundColor: callState.isMicMuted ? Colors.white : null,
//             label: 'Mic',
//           ),

//           if (widget.isVideoCall)
//             _buildControlButton(
//               icon: callState.isCameraOff ? Icons.videocam_off : Icons.videocam,
//               isActive: !callState.isCameraOff,
//               onPressed:
//                   () =>
//                       ref
//                           .read(groupCallControllerProvider.notifier)
//                           .toggleCamera(),
//               backgroundColor: callState.isCameraOff ? Colors.red : null,
//               label: 'Camera',
//             ),

//           _buildControlButton(
//             icon: callState.isSpeakerOn ? Icons.volume_up : Icons.volume_off,
//             isActive: callState.isSpeakerOn,
//             onPressed:
//                 () =>
//                     ref
//                         .read(groupCallControllerProvider.notifier)
//                         .toggleSpeaker(),
//             backgroundColor: callState.isSpeakerOn ? Colors.white : null,
//             label: 'Speaker',
//           ),

//           _buildControlButton(
//             icon: Icons.call_end,
//             onPressed: _endCall,
//             backgroundColor: Colors.red,
//             isDestructive: true,
//             label: 'Leave',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildControlButton({
//     required IconData icon,
//     required VoidCallback onPressed,
//     bool isActive = true,
//     Color? backgroundColor,
//     bool isDestructive = false,
//     String label = '',
//   }) {
//     return Column(
//       children: [
//         Container(
//           width: 56,
//           height: 56,
//           decoration: BoxDecoration(
//             color:
//                 backgroundColor ?? (isActive ? Colors.white24 : Colors.white12),
//             shape: BoxShape.circle,
//           ),
//           child: IconButton(
//             onPressed: onPressed,
//             icon: Icon(
//               icon,
//               color:
//                   isDestructive
//                       ? Colors.white
//                       : (isActive ? Colors.white : Colors.grey),
//               size: 24,
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
//       ],
//     );
//   }
// }

// // Helper class to represent local participant in the grid
// class _LocalParticipantWrapper {
//   final GroupCallState callState;

//   _LocalParticipantWrapper({required this.callState});
// }
