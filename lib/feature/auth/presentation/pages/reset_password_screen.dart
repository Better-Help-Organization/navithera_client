import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/feature/auth/presentation/providers/auth_provider.dart';
import "package:navithera_client/l10n/app_localizations.dart";

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String email;
  const ResetPasswordScreen({required this.email});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _isOtpValid = true;
  String _otpError = '';

  bool _isPasswordValid = true;
  String _passwordError = '';

  bool _isConfirmValid = true;
  String _confirmError = '';

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _validateOtp(String v) {
    final value = v.trim();
    if (value.isEmpty) {
      setState(() {
        _isOtpValid = false;
        _otpError = 'OTP is required';
      });
      return;
    }
    if (value.length != 6 || int.tryParse(value) == null) {
      setState(() {
        _isOtpValid = false;
        _otpError = 'OTP must be 6 digits';
      });
      return;
    }
    setState(() {
      _isOtpValid = true;
      _otpError = '';
    });
  }

  void _validatePassword(String v) {
    final value = v;
    if (value.isEmpty) {
      setState(() {
        _isPasswordValid = false;
        _passwordError = 'Password is required';
      });
      return;
    }
    if (value.length < 6) {
      setState(() {
        _isPasswordValid = false;
        _passwordError = 'Password must be at least 6 characters';
      });
      return;
    }
    setState(() {
      _isPasswordValid = true;
      _passwordError = '';
    });
    _validateConfirm(_confirmPasswordController.text);
  }

  void _validateConfirm(String v) {
    final value = v;
    if (value.isEmpty) {
      setState(() {
        _isConfirmValid = false;
        _confirmError = 'Please confirm your password';
      });
      return;
    }
    if (value != _passwordController.text) {
      setState(() {
        _isConfirmValid = false;
        _confirmError = 'Passwords do not match';
      });
      return;
    }
    setState(() {
      _isConfirmValid = true;
      _confirmError = '';
    });
  }

  void _submit() async {
    final router = ref.read(routerProvider);

    _validateOtp(_otpController.text);
    _validatePassword(_passwordController.text);
    _validateConfirm(_confirmPasswordController.text);

    if (!_isOtpValid || !_isPasswordValid || !_isConfirmValid) return;

    setState(() => _isLoading = true);
    try {
      await ref
          .read(authProvider.notifier)
          .resetPassword(
            widget.email,
            _passwordController.text,
            _confirmPasswordController.text,
            _otpController.text,
          );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset successfully'),
          backgroundColor: Colors.green,
        ),
      );

      router.go("/login");
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
                  // Header spacer with back
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
                  // Logo/title area
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
                                'Reset Password',
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
                                'Reset password for ${widget.email}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF7B7B7B),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            // OTP
                            Text(
                              'OTP Code',
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
                                    _isOtpValid
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
                                controller: _otpController,
                                onChanged: _validateOtp,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                cursorColor: AppColors.secondary,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 15,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock_clock_outlined,
                                    color:
                                        _isOtpValid
                                            ? Color(0xFF7B7B7B)
                                            : AppColors.error,
                                  ),
                                  hintText: '••••••',
                                  counterText: "",
                                ),
                              ),
                            ),
                            if (!_isOtpValid) SizedBox(height: 8),
                            if (!_isOtpValid)
                              Text(
                                _otpError,
                                style: TextStyle(
                                  color: AppColors.error,
                                  fontSize: 12,
                                ),
                              ),
                            SizedBox(height: 20),
                            // New Password
                            Text(
                              'New Password',
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
                                controller: _passwordController,
                                onChanged: _validatePassword,
                                cursorColor: AppColors.secondary,
                                obscureText: _obscurePassword,
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
                                    onPressed:
                                        () => setState(
                                          () =>
                                              _obscurePassword =
                                                  !_obscurePassword,
                                        ),
                                    icon: Icon(
                                      _obscurePassword
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
                            if (!_isPasswordValid)
                              Text(
                                _passwordError,
                                style: TextStyle(
                                  color: AppColors.error,
                                  fontSize: 12,
                                ),
                              ),
                            SizedBox(height: 20),
                            // Confirm Password
                            Text(
                              'Confirm Password',
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
                                    _isConfirmValid
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
                                controller: _confirmPasswordController,
                                onChanged: _validateConfirm,
                                cursorColor: AppColors.secondary,
                                obscureText: _obscureConfirmPassword,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 15,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color:
                                        _isConfirmValid
                                            ? Color(0xFF7B7B7B)
                                            : AppColors.error,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed:
                                        () => setState(
                                          () =>
                                              _obscureConfirmPassword =
                                                  !_obscureConfirmPassword,
                                        ),
                                    icon: Icon(
                                      _obscureConfirmPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color:
                                          _isConfirmValid
                                              ? Color(0xFF7B7B7B)
                                              : AppColors.error,
                                    ),
                                  ),
                                  hintText: '••••••••••',
                                ),
                              ),
                            ),
                            if (!_isConfirmValid) SizedBox(height: 8),
                            if (!_isConfirmValid)
                              Text(
                                _confirmError,
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
                                          "Reset Password",
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
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
