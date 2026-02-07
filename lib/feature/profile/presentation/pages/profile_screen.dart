import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:navithera_client/core/localization/providers/locale_provider.dart';
import 'package:navithera_client/core/providers/socket_provider.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/core/theme/app_typography.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/core/util/avatar_util.dart';
import 'package:navithera_client/feature/auth/presentation/providers/user_provider.dart';
import 'package:navithera_client/feature/auth/presentation/providers/auth_provider.dart';
import 'package:navithera_client/feature/home/presentation/pages/home_screen.dart';
import 'package:navithera_client/feature/home/presentation/providers/matched_therapist_provider.dart';
import 'package:navithera_client/feature/home/presentation/providers/upcoming_session_provider.dart';
import 'package:navithera_client/feature/notification/presentation/pages/notification_screen.dart';
import 'package:navithera_client/feature/profile/presentation/providers/delete_account_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:navithera_client/l10n/app_localizations.dart";
import 'package:url_launcher/url_launcher.dart';
//import "package:navithera_client/l10n/app_localizations.dart";

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String? _accessToken;

  @override
  void initState() {
    super.initState();
    _loadAccessToken();
  }

  Future<void> _getFeedbackPage(BuildContext context) async {
    final Uri url = Uri.parse('https://www.navithera.com/contact');

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        // _showErrorDialog(context, 'Could not open the link');
      }
    } catch (e) {
      // _showErrorDialog(context, 'Something went wrong');
    }
  }

  void _emailUs(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'navithera64@gmail.com',
      query: encodeQueryParameters(<String, String>{'subject': ''}),
    );

    launchUrl(emailLaunchUri);
  }

  void _callUs() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '0998888866');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  Future<void> _loadAccessToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _accessToken = sharedPreferences.getString('access_token');
    });
    print("Access Token: $_accessToken");
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text(AppLocalizations.of(context)!.logout),
            content: Text(AppLocalizations.of(context)!.areYouSureLogout),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await ref.read(authProvider.notifier).logout();
                  ref.read(matchedTherapistProvider.notifier).reset();
                  ref.read(upcomingSessionProvider.notifier).reset();

                  // Properly dispose the socket service
                  final socketService = ref.read(
                    socketServiceProvider.notifier,
                  );
                  socketService.state.disconnect();
                  ref.invalidate(
                    socketServiceProvider,
                  ); // This is key - it destroys the instance

                  final sharedPreferences =
                      await SharedPreferences.getInstance();
                  final accessToken = sharedPreferences.getString(
                    'access_token',
                  );
                  print("access token: ${accessToken}");
                  ref.read(routerProvider).go('/login');
                },
                child: Text(AppLocalizations.of(context)!.logout),
              ),
            ],
          ),
    );
  }

  Future<void> _showDeleteAccountDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text(AppLocalizations.of(context)!.deleteAccount),
            content: Text(AppLocalizations.of(context)!.deleteAccountConfirmation),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await _handleDeleteAccount();
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.error,
                ),
                child: Text(AppLocalizations.of(context)!.confirmDelete),
              ),
            ],
          ),
    );
  }

  Future<void> _handleDeleteAccount() async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    
    // Trigger delete operation
    await ref.read(deleteAccountProvider.notifier).deleteAccount();
    
    // Dismiss loading indicator
    if (mounted) Navigator.pop(context);
    
    // Check result
    final deleteState = ref.read(deleteAccountProvider);
    
    deleteState.when(
      initial: () {},
      loading: () {},
      success: () async {
        // Success - show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.accountDeletedSuccess),
              backgroundColor: Colors.green,
            ),
          );
        }
        
        // Logout and cleanup
        await ref.read(authProvider.notifier).logout();
        ref.read(matchedTherapistProvider.notifier).reset();
        ref.read(upcomingSessionProvider.notifier).reset();
        
        // Dispose socket
        final socketService = ref.read(socketServiceProvider.notifier);
        socketService.state.disconnect();
        ref.invalidate(socketServiceProvider);
        
        // Navigate to login
        if (mounted) {
          ref.read(routerProvider).go('/login');
        }
      },
      error: (error) {
        // Error - show error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.read(routerProvider);
    final user = ref.watch(currentUserProvider);
    //print("User Profile: ${user?.profile}");
    // final profile = ref.watch()

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        //  router.push("/updateProfile");
                        router.push("/updateProfile", extra: 1);
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child:
                              (user?.avatar == 7) &&
                                      (user?.profile != null &&
                                          user!.profile!.isNotEmpty)
                                  ? Image(
                                    image: NetworkImage(
                                      '${base_url_for_image}${user.profile}?v=${DateTime.now().millisecondsSinceEpoch}',
                                    ),
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image(
                                        image: AssetImage(
                                          getAvatarImage(user.avatar ?? 0),
                                        ),
                                        width: 80,
                                        height: 80,
                                      );
                                    },
                                  )
                                  : Image(
                                    image: AssetImage(
                                      getAvatarImage(user?.avatar ?? 0),
                                    ),
                                    width: 80,
                                    height: 80,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.firstName ?? "",
                          style: AppTypography.heading1.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              //  router.push("/updateProfile");
                              router.push("/updateProfile");
                            },
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.updateProfile,
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Manage Account Section
                Text(
                  AppLocalizations.of(context)!.manageAccount,
                  style: AppTypography.heading2.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildListTile(
                  icon: Icons.notifications_outlined,
                  title: AppLocalizations.of(context)!.notification,
                  onTap: () {
                    // router.push("/updateProfile");
                    ref.read(notificationCountProvider.notifier).reset();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                  },
                ),
                // _buildListTile(
                //   icon: Icons.card_giftcard,
                //   title: AppLocalizations.of(context)!.giftTherapy,
                //   onTap: () {},
                //   badge: '${AppLocalizations.of(context)!.xnew}',
                //   badgeColor: AppColors.primary,
                // ),
                _buildListTile(
                  icon: Icons.language,
                  title: AppLocalizations.of(context)!.language,
                  onTap: () => _showLanguageDialog(context),
                ),

                const SizedBox(height: 20),
                // Contact Us Section
                Text(
                  AppLocalizations.of(context)!.contactUs,
                  style: AppTypography.heading2.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // _buildListTile(
                //   icon: Icons.support_agent,
                //   title: AppLocalizations.of(context)!.livechatSupport,
                //   onTap: () {},
                // ),
                _buildListTile(
                  icon: Icons.call_outlined,
                  title: AppLocalizations.of(context)!.callUs,
                  onTap: () => _callUs(),
                ),
                _buildListTile(
                  icon: Icons.email_outlined,
                  title: AppLocalizations.of(context)!.emailUs,
                  onTap: () => _emailUs(context),
                ),

                // _buildListTile(
                //   icon: Icons.bug_report_outlined,
                //   title: AppLocalizations.of(context)!.feedbackAndBugReports,
                //   onTap: () {
                //     _getFeedbackPage(context);
                //   },
                //   //https://www.navithera.com/contact
                // ),
                const SizedBox(height: 20),
                // More Section
                Text(
                  AppLocalizations.of(context)!.more,
                  style: AppTypography.heading2.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildListTile(
                  icon: Icons.logout,
                  title: AppLocalizations.of(context)!.logout,
                  onTap: () => _showLogoutDialog(context),
                  isLogout: true,
                ),
                _buildListTile(
                  icon: Icons.delete_outline,
                  title: AppLocalizations.of(context)!.deleteAccount,
                  onTap: () => _showDeleteAccountDialog(context),
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final currentLocale = ref.read(localeProvider);
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text(l10n.language),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<Locale>(
                  //tileColor: AppColors.primary,
                  //activeColor: AppColors.primary,
                  //fillColor: AppColors.primary,
                  title: Text('English'),
                  value: const Locale('en'),
                  groupValue: currentLocale,
                  onChanged: (Locale? value) {
                    if (value != null) {
                      ref.read(localeProvider.notifier).setLocale(value);
                      Navigator.pop(context);
                    }
                  },
                ),
                RadioListTile<Locale>(
                  title: Text('አማርኛ'),
                  value: const Locale('am'),
                  groupValue: currentLocale,
                  onChanged: (Locale? value) {
                    if (value != null) {
                      ref.read(localeProvider.notifier).setLocale(value);
                      Navigator.pop(context);
                    }
                  },
                ),

                RadioListTile<Locale>(
                  title: Text('Oromigna'),
                  value: const Locale('om'),
                  groupValue: currentLocale,
                  onChanged: (Locale? value) {
                    if (value != null) {
                      ref.read(localeProvider.notifier).setLocale(value);
                      Navigator.pop(context);
                    }
                  },
                ),
                RadioListTile<Locale>(
                  title: Text('Tigrigna'),
                  value: const Locale('ti'),
                  groupValue: currentLocale,
                  onChanged: (Locale? value) {
                    if (value != null) {
                      ref.read(localeProvider.notifier).setLocale(value);
                      Navigator.pop(context);
                    }
                  },
                ),
                RadioListTile<Locale>(
                  title: Text('Somali'),
                  value: const Locale('so'),
                  groupValue: currentLocale,
                  onChanged: (Locale? value) {
                    if (value != null) {
                      ref.read(localeProvider.notifier).setLocale(value);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? badge,
    Color? badgeColor,
    bool isLogout = false,
    bool isDestructive = false,
  }) {
    //final bool isLogout = title.toLowerCase() == 'logout';
    final Color iconBgColor = (isLogout || isDestructive) ? AppColors.error : AppColors.iconGrey;
    final Color textColor = (isLogout || isDestructive) ? AppColors.error : AppColors.textPrimary;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 22, color: Colors.white),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodyLarge.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor?.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  badge,
                  style: AppTypography.bodySmall.copyWith(color: badgeColor),
                ),
              ),
            ],
          ],
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: AppColors.iconGrey,
          size: 20,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
