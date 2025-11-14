import 'dart:math' as Random;
import 'package:flutter/material.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/core/util/avatar_util.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/chat/presentation/widgets/gradient_avatar.dart';
import "dart:developer";

class GroupProfileScreen extends StatefulWidget {
  final String groupName;
  final List<UserModel>? groupMembers; // Add this parameter

  const GroupProfileScreen({
    super.key,
    required this.groupName,
    this.groupMembers,
  });

  @override
  State<GroupProfileScreen> createState() => _GroupProfileScreenState();
}

class _GroupProfileScreenState extends State<GroupProfileScreen> {
  bool notificationsOn = false;

  // Helper method to get random gradient for member avatars
  List<Color> getRandomGradient() {
    final gradients = [
      [const Color(0xFF3CB7CF), const Color(0xFF5AD1E2)],
      [const Color(0xFFF08BA6), const Color(0xFFF7A7A0)],
      [const Color(0xFF827CFF), const Color(0xFFA06BFF)],
      [const Color(0xFF6AA8FF), const Color(0xFF7BC1FF)],
      [const Color(0xFFF595A7), const Color(0xFFF4B6A2)],
    ];
    return gradients[Random.Random().nextInt(gradients.length)];
  }

  @override
  Widget build(BuildContext context) {
    // Convert UserModel objects to Member objects for display
    log("Members: ${widget.groupMembers}");
    final members =
        widget.groupMembers
            ?.map(
              (user) => Member(
                name: '${user.firstName} ${user.lastName}',
                status:
                    user.isOnline == true
                        ? "online"
                        : "offline", // Handles null, false, or other values
                gradient: getRandomGradient(),
                isOwner: false,
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
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.edit_outlined),
        //     onPressed: () {},
        //     tooltip: 'Edit',
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.more_vert),
        //     onPressed: () {},
        //     tooltip: 'More',
        //   ),
        // ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _Header(
              groupName: widget.groupName, // Use the passed group name
              membersCount: members.length,
            ),
          ),
          SliverToBoxAdapter(child: const _SectionDivider(height: 10)),

          SliverToBoxAdapter(child: const _SectionDivider(height: 10)),
          // SliverToBoxAdapter(
          //   child: _Surface(
          //     child: _ActionTile(
          //       leading: _CircleIcon(icon: Icons.person_add_alt_1_rounded),
          //       title: Text(
          //         'Add Members',
          //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          //       ),
          //       onTap: () {},
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(child: const _ThinDivider()),
          SliverList.separated(
            itemCount: members.length,
            separatorBuilder: (_, __) => const _ThinDivider(),
            itemBuilder: (context, index) {
              final m = members[index];
              return _Surface(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  leading: GradientAvatar(
                    label: initials(m.name),
                    gradient: m.gradient,
                    size: 50,
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
                      m.isOwner
                          ? Text(
                            'Owner',
                            style: TextStyle(
                              //  color: _Palette.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                          : null,
                  onTap: () {},
                ),
              );
            },
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 28)),
        ],
      ),
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
              label: initials(groupName), // Use the dynamic group name
              gradient: const [Color(0xFFF595A7), Color(0xFFF4B6A2)],
              size: 68,
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupName, // Use the dynamic group name
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

  const Member({
    required this.name,
    required this.status,
    this.isOwner = false,
    this.gradient = const [Color(0xFF6AA8FF), Color(0xFF7BC1FF)],
  });
}
