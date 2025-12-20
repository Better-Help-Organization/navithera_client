import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import "package:navithera_client/l10n/app_localizations.dart";
import 'package:navithera_client/feature/auth/presentation/providers/auth_provider.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  String? _emailError;

  void _validateEmail(String value) {
    final v = value.trim();
    if (v.isEmpty) {
      setState(() => _emailError = "Email is required");
      return;
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(v)) {
      setState(() => _emailError = "Invalid email address");
      return;
    }
    setState(() => _emailError = null);
  }

  void _submit() async {
    final router = ref.read(routerProvider);
    _validateEmail(_emailController.text);
    if (_emailError != null) return;

    setState(() => _isLoading = true);
    try {
      await ref
          .read(authProvider.notifier)
          .forgotPassword(_emailController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset OTP sent to your email'),
          backgroundColor: Colors.green,
        ),
      );

      router.push("/reset-password", extra: _emailController.text.trim());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

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
                  // Header spacer (matches Login header)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => ref.read(routerProvider).pop(),
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // Logo/title area (matches Login)
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Text(
                                'Forgot Password',
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
                                'Enter your email to receive an OTP for password reset.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF7B7B7B),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              'Email',
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
                                    (_emailError == null)
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
                                controller: _emailController,
                                onChanged: _validateEmail,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: AppColors.secondary,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 15,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color:
                                        (_emailError == null)
                                            ? Color(0xFF7B7B7B)
                                            : AppColors.error,
                                  ),
                                  hintText: 'example@domain.com',
                                ),
                              ),
                            ),
                            if (_emailError != null) SizedBox(height: 8),
                            if (_emailError != null)
                              Text(
                                _emailError!,
                                style: TextStyle(
                                  color: AppColors.error,
                                  fontSize: 12,
                                ),
                              ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 0,
                                ),
                                child:
                                    _isLoading
                                        ? const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        )
                                        : Text(
                                          "Send reset link",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: TextButton(
                                onPressed:
                                    () => ref.read(routerProvider).go('/login'),
                                child: Text(
                                  'Back to Login',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
