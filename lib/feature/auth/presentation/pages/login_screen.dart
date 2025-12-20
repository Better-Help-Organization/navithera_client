import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/localization/providers/locale_provider.dart';
import 'package:navithera_client/core/notification/notification_service.dart';
import 'package:navithera_client/core/providers/socket_provider.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/routes/app_router.dart';
import '../providers/auth_provider.dart';
import "package:navithera_client/l10n/app_localizations.dart";

class LoginPage extends ConsumerStatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _isPasswordVisible = false;
  bool _isPasswordValid = true;
  String _passwordErrorText = '';

  bool _isPhoneValid = true;
  String _phoneErrorText = '';

  final TextEditingController _phoneController = TextEditingController(
    // text: 'test@gmail.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    //text: 'SecurePassword123',
  );

  @override
  void initState() {
    super.initState();
    // Validate initial password
    //_validatePassword(_passwordController.text);
  }

  void _validatePhoneNumber(String phone) {
    setState(() {
      final phoneRegex = RegExp(r'^\d{9}$');
      if (phone.isEmpty) {
        _isPhoneValid = false;
        _phoneErrorText = 'Phone number cannot be empty';
      } else if (!phoneRegex.hasMatch(phone)) {
        _isPhoneValid = false;
        _phoneErrorText = 'Phone number must be exactly 9 digits';
      } else {
        _isPhoneValid = true;
        _phoneErrorText = '';
      }
    });
  }

  void _validatePassword(String password) {
    setState(() {
      _isPasswordValid = password.isNotEmpty;
      _passwordErrorText = _isPasswordValid ? '' : 'Password must not be empty';
    });
  }

  void _handleLogin() async {
    // Make this function async
    final phoneNumber = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    _validatePhoneNumber(phoneNumber);
    _validatePassword(password);

    if (!_isPasswordValid || !_isPhoneValid) {
      return;
    }

    try {
      // Await the token retrieval
      final token = await ref.read(fcmServiceProvider).getToken();
      print("FCM Token: $token");

      if (token != null) {
        ref.read(authProvider.notifier).login(phoneNumber, password, token);
      } else {
        //ref.read(authProvider.notifier).login(phoneNumber, password, "token");
        // Handle case where token is null
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not get device token'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error getting FCM token: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error getting device token'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.read(routerProvider);
    // Watch auth state changes here
    ref.listen<AuthState>(authProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},

        authenticated: (user) async {
          try {
            final socketService = ref.read(socketServiceProvider);
            await socketService.connect();
            print("Socket connected after login");
          } catch (e) {
            print("Socket connection error: $e");
          }

          final hasAnswers =
              user.answers != null &&
              user.answers!.any((a) => a.text?.isNotEmpty == true);
          print("hasAnsers: ${hasAnswers}");
          final hasPreferences =
              user.preferences != null && user.preferences!.isNotEmpty;
          print("hasprefs: ${hasPreferences}");
          final hasSubsription = user.activeSubscription != null;

          final firstStatus =
              user.activeSubscription != null
                  ? user.activeSubscription!.status
                  : null;

          final firstSubscriptionID =
              user.activeSubscription != null
                  ? user.activeSubscription!.id
                  : null;

          final userStatus = user.status!.toLowerCase();

          final firstPreferenceId =
              user.preferences!.isNotEmpty ? user.preferences!.first.id : null;

          print("user Scription: ${firstStatus}");
          final isSubscriptionExpired =
              hasSubsription &&
              user.activeSubscription!.end_date != null &&
              DateTime.now().isAfter(
                DateTime.parse(user.activeSubscription!.end_date!),
              );

          // if (!hasAnswers && !hasPreferences) {
          //   router.go('/categories');
          // } else if (!hasSubsription) {
          //   router.go('/subscription');
          // } else if (firstStatus == "inactive") {
          //   router.go(
          //     '/payment?preferenceId=$firstPreferenceId',
          //     extra: firstSubscriptionID,
          //   );
          // }
          // //  else if (!hasPreferences) {
          // //   router.go('/language-selection');
          // // }
          // else if (userStatus != "active") {
          //   router.go("/blocked-user");
          // } else {
          //   router.go('/main');
          // }
          if (!hasAnswers && !hasPreferences) {
            router.go('/categories');
          } else if (!hasSubsription) {
            router.go('/subscription');
          } else if (firstStatus == "inactive") {
            // router.go('/payment', extra: firstSubscriptionID);
            router.go(
              '/payment?preferenceId=$firstPreferenceId',
              extra: firstSubscriptionID,
            );
          } else if (isSubscriptionExpired) {
            router.go('/categories');
          } else if (userStatus != "active") {
            router.go("/blocked-user");
          } else if (firstStatus != "active") {
            router.go("/blocked-user");
          } else {
            router.go('/main');
          }
          //ref.read(routerProvider).go('/main');
        },
        unauthenticated: () {},
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        },
        unverified: (message) {},
        profileError: (user, message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile update failed: $message'),
              backgroundColor: Colors.red,
            ),
          );
          // Navigate to main or stay on the same page
          // ref.read(routerProvider).go('/main');
        },
      );
    });

    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  // Header
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //   child: Row(children: []),
                  // ),
                  // Logo
                  Container(
                    height: 250,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Add your image here
                          Image.asset(
                            'assets/images/navithera-logo.png', // Replace with your actual image path
                            width: 250, // Adjust size as needed
                            height: 250,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.language), // Globe icon
                                onPressed: () {
                                  showLanguageDialog(context);
                                  // Show language selection dialog or bottom sheet
                                  //  _showLanguageSelection(context);
                                },
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!.welcomeMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF7B7B7B),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            AppLocalizations.of(context)!.phoneNumber,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  _isPhoneValid
                                      ? Border.all(
                                        color: Color(0xFFF5F5F5),
                                        width: 1.5,
                                      )
                                      : Border.all(
                                        color: AppColors.error,
                                        width: 1.5,
                                      ),
                            ),
                            child: TextField(
                              cursorColor: AppColors.secondary,
                              controller: _phoneController,
                              onChanged: _validatePhoneNumber,
                              maxLength: 9,
                              keyboardType: TextInputType.phone,
                              enabled:
                                  !authState.maybeWhen(
                                    loading: () => true,
                                    orElse: () => false,
                                  ),
                              decoration: InputDecoration(
                                hintText: '',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 15,
                                ),
                                counterText: "",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(width: 15),
                                      Row(
                                        children: [
                                          Text(
                                            '🇪🇹',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            '+251',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      //   SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (!_isPhoneValid) SizedBox(height: 8),
                          Text(
                            _phoneErrorText,
                            style: TextStyle(
                              color: AppColors.error,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)!.password,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  _isPasswordValid
                                      ? Border.all(
                                        color: Color(0xFFF5F5F5),
                                        width: 1.5,
                                      )
                                      : Border.all(
                                        color: AppColors.error,
                                        width: 1.5,
                                      ),
                            ),
                            child: TextField(
                              cursorColor: AppColors.secondary,
                              controller: _passwordController,
                              enabled:
                                  !authState.maybeWhen(
                                    loading: () => true,
                                    orElse: () => false,
                                  ),
                              obscureText: !_isPasswordVisible,
                              onChanged: _validatePassword,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 15,
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color:
                                      _isPasswordValid
                                          ? Color(0xFF7B7B7B)
                                          : AppColors.error,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color:
                                        _isPasswordValid
                                            ? Color(0xFF7B7B7B)
                                            : AppColors.error,
                                  ),
                                ),
                                hintText: '••••••••••',
                              ),
                            ),
                          ),
                          if (!_isPasswordValid) SizedBox(height: 8),
                          Text(
                            _passwordErrorText,
                            style: TextStyle(
                              color: AppColors.error,
                              fontSize: 12,
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                router.push("/forgot-password");
                                // Handle forgot password
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Color(0xFF7B7B7B),
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          //SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: authState.maybeWhen(
                                loading: () => null,
                                orElse: () => _handleLogin,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 0,
                              ),
                              child: authState.maybeWhen(
                                loading:
                                    () => const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                orElse:
                                    () => Text(
                                      AppLocalizations.of(context)!.login,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.dontHaveAccount,
                                style: TextStyle(
                                  color: Color(0xFF7B7B7B),
                                  fontSize: 14,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  router.go("/signup");
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.signUp,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showLanguageDialog(BuildContext context) {
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

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
