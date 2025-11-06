// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:navithera_client/core/notification/notification_service.dart';
// import 'package:navithera_client/core/theme/app_colors.dart';
// import 'package:navithera_client/feature/chat/presentation/pages/chat_screen.dart';
// import 'package:navithera_client/feature/therapy/presentation/pages/group_call_screen.dart';
// import 'package:navithera_client/feature/therapy/presentation/pages/user_list_screen.dart';
// import 'call_screen.dart';

// class TherapyScreen extends ConsumerStatefulWidget {
//   const TherapyScreen({super.key});

//   @override
//   ConsumerState<TherapyScreen> createState() => _TherapyScreenState();
// }

// class _TherapyScreenState extends ConsumerState<TherapyScreen> {
//   // Dummy data
//   final List<Chat> chats = [
//     Chat(
//       id: 1,
//       name: 'Alex Johnson',
//       lastMessage: 'Hey, are we still meeting tomorrow?',
//       avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
//       unreadCount: 3,
//       timestamp: DateTime(2025, 4, 3, 10, 30),
//       isOnline: true,
//     ),
//   ];

//   String _formatTime(DateTime dt) {
//     final now = DateTime.now();
//     final diff = now.difference(dt);

//     if (diff.inDays > 365) {
//       return '${dt.year}/${dt.month}/${dt.day}';
//     } else if (diff.inDays > 7) {
//       return '${dt.month}/${dt.day}';
//     } else if (diff.inDays > 1) {
//       return '${diff.inDays}d ago';
//     } else if (diff.inHours > 1) {
//       return '${diff.inHours}h ago';
//     } else if (diff.inMinutes > 1) {
//       return '${diff.inMinutes}m ago';
//     } else {
//       return 'Just now';
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Initialize FCM service
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(fcmServiceProvider).setContext(context);
//     });
//   }

//   @override
//   void dispose() {
//     _roomController.dispose();
//     _nameController.dispose();
//     super.dispose();
//   }

//   void _startAudioCall() {
//     if (_roomController.text.trim().isEmpty ||
//         _nameController.text.trim().isEmpty) {
//
//       return;
//     }

//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder:
//             (context) => GroupCallScreen(
//               roomName: _roomController.text.trim(),
//               participantName: _nameController.text.trim(),
//               isVideoCall: false,
//             ),
//       ),
//     );
//   }

//   void _startVideoCall() {
//     if (_roomController.text.trim().isEmpty ||
//         _nameController.text.trim().isEmpty) {
//     }

//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder:
//             (context) => CallScreen(
//               roomName: _roomController.text.trim(),
//               participantName: _nameController.text.trim(),
//               isVideoCall: true,
//             ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'My Therapist',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         centerTitle: true,
//         //actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
//       ),
//       body: ListView.builder(
//         itemCount: chats.length,
//         itemBuilder: (context, index) {
//           final chat = chats[index];
//           return ListTile(
//             leading: Stack(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(
//                     chat.avatarUrl ?? 'https://via.placeholder.com/150',
//                   ),
//                 ),
//                 if (chat.isOnline)
//                   Positioned(
//                     right: 0,
//                     bottom: 0,
//                     child: Container(
//                       width: 12,
//                       height: 12,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Theme.of(context).scaffoldBackgroundColor,
//                           width: 2,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(width: 16),

//                     // Video call button
//                     Expanded(
//                       child: Container(
//                         height: 120,
//                         child: ElevatedButton(
//                           onPressed: _startVideoCall,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             foregroundColor: AppColors.secondary,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             elevation: 4,
//                           ),
//                           child: const Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.videocam, size: 32),
//                               SizedBox(height: 8),
//                               Text(
//                                 'Video Call',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'Audio & Video',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: AppColors.secondary,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 40),

//                 OutlinedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => UsersListScreen(),
//                       ),
//                     );
//                     //  Navigator.of(context).push(
//                     //   MaterialPageRoute(builder: (context) => ChatListScreen()),
//                     // );
//                     //   Navigator.of(context).push(
//                     //   MaterialPageRoute(
//                     //     builder: (context) => const SimpleTestScreen(),
//                     //   ),
//                     // );
//                     // ref
//                     //     .read(fcmServiceProvider)
//                     //     .sendPushNotification(
//                     //       deviceToken:
//                     //           "dRAUkrSqS0-BQWYcRW6nsX:APA91bHdC__-c3ZX1wSvT0dCaJ7MdHQmT3hgP2H9_bIhqm4zEUOWeyCWvSeLXH2QGMGl_njJqXMPCR9_Iw7FKK8OuH_-YlGwz4yvmlsfH7a18PRGTIDkYD0",
//                     //       title: 'Call',
//                     //       body: 'Call from Navicare',
//                     //     );
//                     //  _startCall();
//                   },
//                   child: const Text(
//                     'Patient Chat List',
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 ),
//               ],
//             ),
//             onTap: () {
//               // _startCall();
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ChatMessageScreen(chat: chat),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
