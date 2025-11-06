// import 'package:flutter/material.dart';

// // Contact class remains the same
// class Contact {
//   final String name;
//   final String status;
//   final Color color;
//   final bool hasImage;

//   Contact(this.name, this.status, this.color, {this.hasImage = false});
// }

// class AddMemberSheet extends StatefulWidget {
//   const AddMemberSheet({super.key});

//   @override
//   _AddMemberSheetState createState() => _AddMemberSheetState();
// }

// class _AddMemberSheetState extends State<AddMemberSheet> {
//   final DraggableScrollableController _controller =
//       DraggableScrollableController();
//   bool _isExpanded = false;

//   final List<Contact> contacts = [
//     Contact('John', 'Client', Colors.blue, hasImage: true),
//     Contact('Absu', 'Client', Colors.pink),
//     Contact('F', 'Client', Colors.brown, hasImage: true),
//     // Add more contacts for testing scroll
//     Contact('Maria', 'Therapist', Colors.green),
//     Contact('David', 'Client', Colors.orange, hasImage: true),
//     Contact('Sara', 'Therapist', Colors.purple),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       final currentSize = _controller.size;
//       // Check if sheet is almost fully expanded
//       if (currentSize > 0.95 && !_isExpanded) {
//         setState(() {
//           _isExpanded = true;
//         });
//       } else if (currentSize <= 0.95 && _isExpanded) {
//         setState(() {
//           _isExpanded = false;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 1. WRAP with a GestureDetector to detect taps outside the sheet
//     return GestureDetector(
//       onTap: () => Navigator.of(context).pop(),
//       child: Container(
//         color: Colors.transparent, // Necessary to make the empty space tappable
//         child: DraggableScrollableSheet(
//           controller: _controller,
//           initialChildSize: 0.6,
//           minChildSize: 0.3,
//           maxChildSize: 1.0, // Can still go fullscreen
//           builder: (context, scrollController) {
//             // 2. WRAP the sheet's content to PREVENT taps inside from closing it
//             return GestureDetector(
//               onTap: () {}, // Do nothing, "swallowing" the tap
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF2A2A2A),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(_isExpanded ? 0 : 16),
//                     topRight: Radius.circular(_isExpanded ? 0 : 16),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     // Handle and header
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       child: Column(
//                         children: [
//                           if (!_isExpanded)
//                             Container(
//                               width: 40,
//                               height: 4,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[600],
//                                 borderRadius: BorderRadius.circular(2),
//                               ),
//                             ),
//                           SizedBox(height: _isExpanded ? 40 : 16),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: Row(
//                               children: [
//                                 if (_isExpanded)
//                                   IconButton(
//                                     onPressed: () => Navigator.pop(context),
//                                     icon: const Icon(
//                                       Icons.arrow_back,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 if (_isExpanded) const SizedBox(width: 8),
//                                 const Text(
//                                   'Add Member',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Content area
//                     Expanded(
//                       child: Column(
//                         children: [
//                           // Search bar
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 8,
//                             ),
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 hintText: 'Search',
//                                 hintStyle: TextStyle(color: Colors.grey[500]),
//                                 prefixIcon: Icon(
//                                   Icons.search,
//                                   color: Colors.grey[500],
//                                 ),
//                                 filled: true,
//                                 fillColor: Colors.grey[800],
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 contentPadding: EdgeInsets.zero,
//                               ),
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           ),

//                           // Contacts list
//                           Expanded(
//                             child: ListView.builder(
//                               controller: scrollController,
//                               itemCount: contacts.length,
//                               itemBuilder: (context, index) {
//                                 final contact = contacts[index];
//                                 return ContactTile(contact: contact);
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // ContactTile widget remains the same
// class ContactTile extends StatelessWidget {
//   final Contact contact;

//   const ContactTile({super.key, required this.contact});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 64, // fixed height for consistent layout
//       margin: const EdgeInsets.symmetric(horizontal: 12), // outer spacing only
//       decoration: BoxDecoration(
//         color: const Color(0xFF2A2A2A),
//         border: Border(
//           bottom: BorderSide(
//             color: const Color.fromARGB(255, 7, 36, 59).withOpacity(0.4),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(
//         children: [
//           const SizedBox(width: 8),
//           CircleAvatar(
//             radius: 22,
//             backgroundColor: contact.color,
//             child: Text(
//               contact.name
//                   .split(' ')
//                   .map((e) => e[0])
//                   .take(2)
//                   .join('')
//                   .toUpperCase(),
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   contact.name,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 Text(
//                   contact.status,
//                   style: TextStyle(color: Colors.grey[500], fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.phone, color: Colors.blue[400]),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:navithera_client/feature/therapy/presentation/providers/users_provider.dart';

// class AddMemberSheet extends ConsumerStatefulWidget {
//   const AddMemberSheet({super.key});

//   @override
//   ConsumerState<AddMemberSheet> createState() => _AddMemberSheetState();
// }

// class _AddMemberSheetState extends ConsumerState<AddMemberSheet> {
//   final DraggableScrollableController _controller =
//       DraggableScrollableController();
//   bool _isExpanded = false;
//   final List<Color> _randomColors = [
//     Colors.blue,
//     Colors.pink,
//     Colors.brown,
//     Colors.green,
//     Colors.orange,
//     Colors.purple,
//     Colors.teal,
//     Colors.indigo,
//     Colors.cyan,
//     Colors.deepOrange,
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       final currentSize = _controller.size;
//       if (currentSize > 0.95 && !_isExpanded) {
//         setState(() {
//           _isExpanded = true;
//         });
//       } else if (currentSize <= 0.95 && _isExpanded) {
//         setState(() {
//           _isExpanded = false;
//         });
//       }
//     });

//     // Fetch users when the sheet is opened
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(usersProvider.notifier).getUsers();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Color _getRandomColor(int index) {
//     return _randomColors[index % _randomColors.length];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final usersState = ref.watch(usersProvider);

//     return GestureDetector(
//       onTap: () => Navigator.of(context).pop(),
//       child: Container(
//         color: Colors.transparent,
//         child: DraggableScrollableSheet(
//           controller: _controller,
//           initialChildSize: 0.6,
//           minChildSize: 0.3,
//           maxChildSize: 1.0,
//           builder: (context, scrollController) {
//             return GestureDetector(
//               onTap: () {},
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF2A2A2A),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(_isExpanded ? 0 : 16),
//                     topRight: Radius.circular(_isExpanded ? 0 : 16),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     // Handle and header
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       child: Column(
//                         children: [
//                           if (!_isExpanded)
//                             Container(
//                               width: 40,
//                               height: 4,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[600],
//                                 borderRadius: BorderRadius.circular(2),
//                               ),
//                             ),
//                           SizedBox(height: _isExpanded ? 40 : 16),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: Row(
//                               children: [
//                                 if (_isExpanded)
//                                   IconButton(
//                                     onPressed: () => Navigator.pop(context),
//                                     icon: const Icon(
//                                       Icons.arrow_back,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 if (_isExpanded) const SizedBox(width: 8),
//                                 const Text(
//                                   'Add Member',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Content area
//                     Expanded(
//                       child: Column(
//                         children: [
//                           // Search bar
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 8,
//                             ),
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 hintText: 'Search',
//                                 hintStyle: TextStyle(color: Colors.grey[500]),
//                                 prefixIcon: Icon(
//                                   Icons.search,
//                                   color: Colors.grey[500],
//                                 ),
//                                 filled: true,
//                                 fillColor: Colors.grey[800],
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 contentPadding: EdgeInsets.zero,
//                               ),
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           ),

//                           // Users list based on state
//                           Expanded(
//                             child: Builder(
//                               builder: (context) {
//                                 if (usersState is Initial) {
//                                   return const Center(
//                                       child: Text('No users loaded'));
//                                 } else if (usersState is Loading) {
//                                   return const Center(
//                                       child: CircularProgressIndicator());
//                                 } else if (usersState is Error) {
//                                   return Center(
//                                       child: Text(usersState.failure.toString()));
//                                 } else if (usersState is Loaded) {
//                                   return ListView.builder(
//                                     controller: scrollController,
//                                     itemCount: usersState.users.length,
//                                     itemBuilder: (context, index) {
//                                       final user = usersState.users[index];
//                                       final color = _getRandomColor(index);

//                                       return Container(
//                                         height: 64,
//                                         margin: const EdgeInsets.symmetric(
//                                             horizontal: 12),
//                                         decoration: BoxDecoration(
//                                           color: const Color(0xFF2A2A2A),
//                                           border: Border(
//                                             bottom: BorderSide(
//                                               color: const Color.fromARGB(
//                                                       255, 7, 36, 59)
//                                                   .withOpacity(0.4),
//                                               width: 1,
//                                             ),
//                                           ),
//                                         ),
//                                         child: Row(
//                                           children: [
//                                             const SizedBox(width: 8),
//                                             CircleAvatar(
//                                               radius: 22,
//                                               backgroundColor: color,
//                                               child: Text(
//                                                 '${user.firstName[0]}${user.lastName[0]}'
//                                                     .toUpperCase(),
//                                                 style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.w500,
//                                                   fontSize: 16,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(width: 12),
//                                             Expanded(
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     '${user.firstName} ${user.lastName}',
//                                                     style: const TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 16,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     user.email ?? 'No email',
//                                                     style: TextStyle(
//                                                         color: Colors.grey[500],
//                                                         fontSize: 14),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             IconButton(
//                                               onPressed: () {},
//                                               icon: Icon(Icons.phone,
//                                                   color: Colors.blue[400]),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   );
//                                 }
//                                 return const SizedBox();
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/feature/therapy/presentation/providers/users_provider.dart';

class AddMemberSheet extends ConsumerStatefulWidget {
  const AddMemberSheet({super.key});

  @override
  ConsumerState<AddMemberSheet> createState() => _AddMemberSheetState();
}

class _AddMemberSheetState extends ConsumerState<AddMemberSheet> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  final ScrollController _scrollController = ScrollController();
  bool _isExpanded = false;
  final List<Color> _randomColors = [
    Colors.blue,
    Colors.pink,
    Colors.brown,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.indigo,
    Colors.cyan,
    Colors.deepOrange,
  ];

  @override
  void initState() {
    super.initState();

    // Initialize scroll controllers
    _sheetController.addListener(_updateSheetState);
    _scrollController.addListener(_scrollListener);

    // Fetch initial users
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(usersProvider.notifier).getUsers();
    });
  }

  @override
  void dispose() {
    _sheetController.removeListener(_updateSheetState);
    _sheetController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateSheetState() {
    final currentSize = _sheetController.size;
    if (currentSize > 0.95 && !_isExpanded) {
      setState(() => _isExpanded = true);
    } else if (currentSize <= 0.95 && _isExpanded) {
      setState(() => _isExpanded = false);
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final state = ref.read(usersProvider);
      if (state is Loaded && state.canLoadMore) {
        ref.read(usersProvider.notifier).getUsers(loadMore: true);
      }
    }
  }

  Future<void> _handleRefresh() async {
    await ref.read(usersProvider.notifier).getUsers();
  }

  Color _getRandomColor(int index) {
    return _randomColors[index % _randomColors.length];
  }

  @override
  Widget build(BuildContext context) {
    final usersState = ref.watch(usersProvider);

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.transparent,
        child: DraggableScrollableSheet(
          controller: _sheetController,
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_isExpanded ? 0 : 16),
                    topRight: Radius.circular(_isExpanded ? 0 : 16),
                  ),
                ),
                child: Column(
                  children: [
                    // Header section
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          if (!_isExpanded)
                            Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[600],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          SizedBox(height: _isExpanded ? 40 : 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                if (_isExpanded)
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                if (_isExpanded) const SizedBox(width: 8),
                                const Text(
                                  'Add Member',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Content area
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _handleRefresh,
                        child: Column(
                          children: [
                            // Search bar
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  hintStyle: TextStyle(color: Colors.grey[500]),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey[500],
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[800],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),

                            // Users list
                            Expanded(
                              child: Builder(
                                builder: (context) {
                                  if (usersState is Initial) {
                                    return const Center(
                                      child: Text('No users loaded'),
                                    );
                                  } else if (usersState is Loading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (usersState is Error) {
                                    return Center(
                                      child: Text(
                                        usersState.failure.toString(),
                                      ),
                                    );
                                  } else if (usersState is Loaded) {
                                    return ListView.builder(
                                      controller: _scrollController,
                                      itemCount:
                                          usersState.users.length +
                                          (usersState.canLoadMore ? 1 : 0),
                                      itemBuilder: (context, index) {
                                        // Loading indicator at the bottom
                                        if (index >= usersState.users.length) {
                                          return const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        }

                                        final user = usersState.users[index];
                                        final color = _getRandomColor(index);

                                        return Container(
                                          height: 64,
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2A2A2A),
                                            border: Border(
                                              bottom: BorderSide(
                                                color: const Color.fromARGB(
                                                  255,
                                                  7,
                                                  36,
                                                  59,
                                                ).withOpacity(0.4),
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 8),
                                              CircleAvatar(
                                                radius: 22,
                                                backgroundColor: color,
                                                child: Text(
                                                  '${user.firstName[0]}${user.lastName[0]}'
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${user.firstName} ${user.lastName}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      user.email ?? 'No email',
                                                      style: TextStyle(
                                                        color: Colors.grey[500],
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.phone,
                                                  color: Colors.blue[400],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  return const SizedBox();
                                },
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
}
