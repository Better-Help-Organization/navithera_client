import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/core/util/avatar_util.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/chat/presentation/widgets/gradient_avatar.dart';
import 'package:navithera_client/feature/therapy/presentation/pages/call_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupProfileScreen extends StatefulWidget {
  final String groupName;
  final List<UserModel>? groupMembers; // Add this parameter
  // final String chatId;

  const GroupProfileScreen({
    super.key,
    required this.groupName,
    this.groupMembers,
    // required this.chatId,
  });

  @override
  State<GroupProfileScreen> createState() => _GroupProfileScreenState();
}

class _GroupProfileScreenState extends State<GroupProfileScreen> {
  bool notificationsOn = false;
  final Set<String> _selectedUserIds = {};
  bool _isSelectionMode = false;

  final String groupName = 'Test';

  void _toggleUserSelection(UserModel user) {
    setState(() {
      if (_selectedUserIds.contains(user.id)) {
        _selectedUserIds.remove(user.id);
      } else {
        _selectedUserIds.add(user.id);
      }
    });
  }

  void _startCallWithSelectedUsers() {
    String _generateRandomRoomName() {
      const chars =
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      final random = Random();
      return String.fromCharCodes(
        Iterable.generate(
          8,
          (_) => chars.codeUnitAt(random.nextInt(chars.length)),
        ),
      );
    }

    // Future<void> _startCall({bool isVideoCall = false}) async {
    //   final sharedPreferences = await SharedPreferences.getInstance();

    //   final accessToken = sharedPreferences.getString('access_token');
    //   final roomName = _generateRandomRoomName();

    //   try {
    //     final dio = Dio();
    //     dio.options.headers['Authorization'] = 'Bearer $accessToken';

    //     final response = await dio.post(
    //       '${base_url_dev}/chat/call/${widget.chatId}',
    //       data: {
    //         'room': roomName,
    //         'isVideoCall': isVideoCall,
    //         "calleeIds": _selectedUserIds.toList(),
    //       },
    //     );

    //     print("responsexoxo: ${response.data}");

    //     if (response.statusCode == 201) {
    //       if (!mounted) return;
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder:
    //               (context) => CallScreen(
    //                 roomName: roomName,
    //                 participantName: "Group Call",
    //                 isVideoCall: isVideoCall,
    //                 chatId: widget.chatId,
    //                 //   isGroupCall: widget.chat.isGroup ?? false,
    //               ),
    //         ),
    //       );
    //     } else {
    //       if (!mounted) return;
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           content: Text('Failed to start call'),
    //           backgroundColor: Colors.red,
    //         ),
    //       );
    //     }
    //   } on DioException catch (e) {
    //     if (!mounted) return;
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('Error: ${e.response?.data['message'] ?? e.message}'),
    //         backgroundColor: Colors.red,
    //       ),
    //     );
    //   } catch (e) {
    //     if (!mounted) return;
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         content: Text('An unexpected error occurred'),
    //         backgroundColor: Colors.red,
    //       ),
    //     );
    //   }
    // }

    // print("Selected chatid: ${widget.chatId}");
    // print('Selected user IDs: ${_selectedUserIds.toList()}');
    // _startCall(isVideoCall: false);
    // Show confirmation dialog or snackbar
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(
    //       'Starting call with ${_selectedUserIds.length} user${_selectedUserIds.length > 1 ? 's' : ''}',
    //       style: TextStyle(color: Colors.white),
    //     ),
    //     backgroundColor: Colors.green,
    //     duration: Duration(seconds: 2),
    //   ),
    // );
  }

  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      if (!_isSelectionMode) {
        _selectedUserIds.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Convert UserModel objects to Member objects for display
    final members =
        widget.groupMembers
            ?.map(
              (user) => Member(
                name: '${user.firstName} ${user.lastName}',
                status: 'online', // You can customize this based on your data
                gradient: getRandomGradient(),
                isOwner: false, // Set this based on your logic
                user: user,
              ),
            )
            .toList() ??
        [];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
          tooltip: 'Back',
        ),
        title:
            _isSelectionMode
                ? Text(
                  '${_selectedUserIds.length} selected',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
                : null,
        actions: [
          // if (widget.groupMembers != null && widget.groupMembers!.isNotEmpty)
          //   IconButton(
          //     icon: Icon(
          //       _isSelectionMode ? Icons.close : Icons.group_add,
          //       color: Colors.white,
          //     ),
          //     onPressed: _toggleSelectionMode,
          //     tooltip:
          //         _isSelectionMode
          //             ? 'Cancel selection'
          //             : 'Select users for call',
          //   ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _Header(groupName: groupName, membersCount: members.length),
          ),
          SliverToBoxAdapter(child: const _SectionDivider(height: 10)),

          SliverToBoxAdapter(child: const _SectionDivider(height: 10)),

          // Selection info banner when in selection mode
          if (_isSelectionMode)
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue.shade700,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _selectedUserIds.isEmpty
                            ? 'Tap on users to select them for the call'
                            : '${_selectedUserIds.length} user${_selectedUserIds.length > 1 ? 's' : ''} selected for call',
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (_selectedUserIds.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _selectedUserIds.length.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

          SliverList.separated(
            itemCount: members.length,
            separatorBuilder: (_, __) => const _ThinDivider(),
            itemBuilder: (context, index) {
              final m = members[index];
              final isSelected = _selectedUserIds.contains(m.user.id);

              return _Surface(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  leading: Stack(
                    children: [
                      GradientAvatar(
                        label: initials(m.name),
                        gradient: m.gradient,
                        size: 50,
                      ),
                      if (_isSelectionMode)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? Colors.green
                                      : Colors.grey.shade300,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child:
                                isSelected
                                    ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 12,
                                    )
                                    : null,
                          ),
                        ),
                    ],
                  ),
                  title: Text(
                    m.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(m.status),
                  trailing:
                      _isSelectionMode
                          ? null
                          : m.isOwner
                          ? Text(
                            'Owner',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                          : null,
                  onTap:
                      _isSelectionMode
                          ? () => _toggleUserSelection(m.user)
                          : null,
                  tileColor: isSelected ? Colors.blue.shade50 : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 28)),
        ],
      ),
      // Floating call button that appears when users are selected
      floatingActionButton:
          _isSelectionMode && _selectedUserIds.isNotEmpty
              ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Audio call button
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: FloatingActionButton.extended(
                      onPressed: _startCallWithSelectedUsers,
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      icon: Icon(Icons.call, size: 24),
                      label: Text(
                        'Audio Call',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // Video call button
                  FloatingActionButton.extended(
                    onPressed: _startCallWithSelectedUsers,
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    icon: Icon(Icons.video_call, size: 24),
                    label: Text(
                      'Video Call',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
              : null,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.groupName, required this.membersCount});

  final String groupName;
  final int membersCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
        child: Row(
          children: [
            GradientAvatar(
              label: initials(groupName),
              gradient: const [Color(0xFFF595A7), Color(0xFFF4B6A2)],
              size: 68,
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$membersCount members',
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------- Reusable bits ---------- */

class _Surface extends StatelessWidget {
  const _Surface({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(child: child, color: Colors.white);
  }
}

class _ThinDivider extends StatelessWidget {
  const _ThinDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, thickness: 1, color: Colors.grey[200]);
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({this.height = 12});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(height: height);
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.leading, required this.title, this.onTap});

  final Widget leading;
  final Widget title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 14),
            Expanded(
              child: Align(alignment: Alignment.centerLeft, child: title),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.red, size: 20),
    );
  }
}

/* ---------- Models & helpers ---------- */

class Member {
  final String name;
  final String status;
  final bool isOwner;
  final List<Color> gradient;
  final UserModel user;

  const Member({
    required this.name,
    required this.status,
    this.isOwner = false,
    this.gradient = const [Color(0xFF6AA8FF), Color(0xFF7BC1FF)],
    required this.user,
  });
}
