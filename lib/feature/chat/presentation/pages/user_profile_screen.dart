import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/util/avatar_util.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/auth/domain/entities/user.dart';
import 'package:navithera_client/feature/chat/domain/repositories/chat_repository.dart';

class ContactDetailPage extends ConsumerStatefulWidget {
  //class ContactDetailPage extends StatefulWidget {
  final String therapistId;
  final String? avatarUrl;

  const ContactDetailPage({
    super.key,
    required this.therapistId,
    this.avatarUrl,
  });

  @override
  ConsumerState<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends ConsumerState<ContactDetailPage> {
  bool notificationsOn = true;
  UserModel? therapist;
  bool isLoading = true;
  String? errorMessage;
  //bool notificationsOn = true;

  // // All colors are set explicitly (no Theme usage)
  // static const Color scaffoldBg = Color(0xFF1F2A33);
  // static const Color appBarBg = Color(0xFF1F2A33);
  // static const Color appBarIcon = Colors.white70;
  // static const Color headerText = Colors.white;
  // static const Color subText = Color(0xFFB0BEC5); // muted gray-blue
  // static const Color sectionDivider = Color(0x1FFFFFFF);
  // static const Color tileIcon = Colors.white70;
  // static const Color tileTitle = Colors.white;
  // static const Color tileSubtitle = Color(0xFF90A4AE);
  // static const Color accent = Color(0xFF4AA0FF);
  // static const Color accentDim = Color(0x334AA0FF);
  // static const Color fabShadow = Colors.black54;

  @override
  void initState() {
    super.initState();
    _fetchTherapistInfo();
  }

  Future<void> _fetchTherapistInfo() async {
    try {
      // You'll need to add this method to your ChatRepository
      final response = await ref
          .read(chatRepositoryProvider)
          .getTherapistInfo(widget.therapistId);

      response.fold(
        (failure) {
          setState(() {
            errorMessage = failure.toString();
            isLoading = false;
          });
        },
        (user) {
          setState(() {
            therapist = user;
            isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load therapist info';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(child: Text("${widget.therapistId} - ${errorMessage!}")),
      );
    }

    if (therapist == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(child: Text('Therapist not found')),
      );
    }

    return Scaffold(
      //  backgroundColor: scaffoldBg,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                //  backgroundColor: appBarBg,
                elevation: 0,
                pinned: true,
                expandedHeight: 170,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back, //color: appBarIcon
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                // actions: const [
                //   _TopAction(icon: Icons.call_outlined),
                //   _TopAction(icon: Icons.videocam_outlined),
                //   // _TopAction(icon: Icons.more_vert),
                // ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    //    color: appBarBg,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 70,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // CircleAvatar(
                        //   radius: 32,

                        //   child: Text(
                        //     initials(therapist!.firstName ?? '?'),
                        //     style: const TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 22,
                        //       fontWeight: FontWeight.w700,
                        //     ),
                        //   ),
                        // ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child:
                              widget.avatarUrl != null &&
                                      widget.avatarUrl!.isNotEmpty
                                  ? Image(
                                    image: NetworkImage('${widget.avatarUrl}'),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image(
                                        image: AssetImage(
                                          getAvatarImage(
                                            therapist?.avatar ?? 0,
                                          ),
                                        ),
                                        width: 80,
                                        height: 80,
                                      );
                                    },
                                  )
                                  : Image.asset(
                                    getAvatarImage(therapist?.avatar ?? 0),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${therapist!.firstName} ${therapist!.lastName}',
                                style: TextStyle(
                                  //   color: headerText,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 4),
                              // Text(
                              //   'last seen recently',
                              //   style: TextStyle(color: subText, fontSize: 14),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // "Info" label
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    //    color: scaffoldBg,
                    border: Border(
                      //    top: BorderSide(color: sectionDivider),
                      //  bottom: BorderSide(color: sectionDivider),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: const Text(
                    'Info',
                    style: TextStyle(
                      //  color: subText,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Phone
              SliverToBoxAdapter(
                child: _InfoTile(
                  icon: Icons.phone_outlined,
                  //  title: '+251 966333770',
                  title: '+251  ${therapist!.phoneNumber}' ?? 'No phone number',
                  subtitle: 'Mobile',
                ),
              ),

              // Username + QR
              SliverToBoxAdapter(
                child: _InfoTile(
                  icon: Icons.alternate_email_outlined,
                  //  title: '@Forsythe_03',
                  title: therapist!.email ?? 'No email address',
                  subtitle: 'Email',
                  // trailing: IconButton(
                  //   icon: const Icon(
                  //     Icons.qr_code_2_outlined, //color: tileIcon
                  //   ),
                  //   onPressed: () {},
                  // ),
                ),
              ),

              // Notifications
              // SliverToBoxAdapter(
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 16,
              //       vertical: 12,
              //     ),
              //     // color: scaffoldBg,
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Row(
              //           children: [
              //             const Icon(
              //               Icons.notifications_none_outlined,
              //               //   color: tileIcon,
              //             ),
              //             const SizedBox(width: 16),
              //             const Expanded(
              //               child: Text(
              //                 'Notifications',
              //                 style: TextStyle(
              //                   //    color: tileTitle,
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w600,
              //                 ),
              //               ),
              //             ),
              //             _ColoredSwitch(
              //               value: notificationsOn,
              //               onChanged:
              //                   (v) => setState(() => notificationsOn = v),
              //             ),
              //           ],
              //         ),
              //         const SizedBox(height: 6),
              //         const Divider(
              //           // color: sectionDivider,
              //           indent: 56,
              //           thickness: 0.6,
              //           height: 0,
              //         ),
              //         const SizedBox(height: 8),
              //         const Padding(
              //           padding: EdgeInsets.only(left: 56),
              //           child: Text(
              //             'On',
              //             style: TextStyle(
              //               //color: tileSubtitle,
              //               fontSize: 14,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const SliverFillRemaining(
                hasScrollBody: false,
                child: SizedBox(),
              ),
            ],
          ),

          // Floating message button
        ],
      ),
    );
  }
}

class _TopAction extends StatelessWidget {
  final IconData icon;
  const _TopAction({required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        //color: _ContactDetailPageState.appBarIcon
      ),
      onPressed: () {},
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const _InfoTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: const Color(0x22FFFFFF),
      highlightColor: const Color(0x11FFFFFF),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              //color: _ContactDetailPageState.tileIcon
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      //  color: _ContactDetailPageState.tileTitle,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        //  color: _ContactDetailPageState.tileSubtitle,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _ColoredSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ColoredSwitch({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      //    activeColor: _ContactDetailPageState.accent, // thumb
      //  activeTrackColor: _ContactDetailPageState.accentDim, // track
      inactiveThumbColor: Colors.white38,
      inactiveTrackColor: Colors.white12,
      splashRadius: 18,
    );
    // No Theme used; colors are provided directly here.
  }
}
