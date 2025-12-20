import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/localization/providers/locale_provider.dart';
import 'package:navithera_client/core/notification/notification_service.dart';
import 'package:navithera_client/core/providers/socket_provider.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import "package:navithera_client/l10n/app_localizations.dart";
import 'package:navithera_client/feature/auth/presentation/providers/auth_provider.dart';
import 'package:url_launcher/url_launcher.dart';

//class SignupPage extends StatefulWidget {
class SignupPage extends ConsumerStatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

//class _SignupPageState extends State<SignupPage> {
class _SignupPageState extends ConsumerState<SignupPage> {
  // errors
  bool _isFirstNameValid = true;
  String _firstNameErrorText = '';

  bool _isLastNameValid = true;
  String _lastNameErrorText = '';

  bool _isUsernameValid = true;
  String _usernameErrorText = '';

  bool _isEmailValid = true;
  String _emailErrorText = '';

  bool _isPhoneValid = true;
  String _phoneErrorText = '';

  bool _isPasswordValid = true;
  String _passwordErrorText = '';

  //password visiblity
  bool _isPasswordVisible = false;

  String _selectedGender = 'male';
  DateTime _selectedDate = DateTime.now();

  final TextEditingController _firstNameController = TextEditingController(
    // text: 'Ciroma',
  );
  final TextEditingController _lastNameController = TextEditingController(
    // text: 'Adekunle',
  );
  final TextEditingController _usernameController = TextEditingController(
    // text: 'abebe123',
  );
  final TextEditingController _emailController = TextEditingController(
    // text: 'ciroma.adekunle@mail.com',
  );
  final TextEditingController _phoneController = TextEditingController(
    //text: '+251',
  );
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          // data: Theme.of(context).copyWith(
          //   colorScheme: ColorScheme.light(
          //     //primary: Color(0xFF2B2D5A),
          //     // primary: AppColors.primary,
          //     // onPrimary: Colors.white,
          //     // surface: Colors.white,
          //     // onSurface: AppColors.primary,
          //   ),
          // ),
          data: Theme.of(context),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  void _validateFirstName(String firstName) {
    setState(() {
      if (firstName.isEmpty) {
        _isFirstNameValid = false;
        _firstNameErrorText = 'First name cannot be empty';
      } else if (RegExp(r'[0-9]').hasMatch(firstName)) {
        _isFirstNameValid = false;
        _firstNameErrorText = 'First name cannot contain numbers';
      } else {
        _isFirstNameValid = true;
        _firstNameErrorText = '';
      }
    });
  }

  void _validateLastName(String lastName) {
    setState(() {
      if (lastName.isEmpty) {
        _isLastNameValid = false;
        _lastNameErrorText = 'Last name cannot be empty';
      } else if (RegExp(r'[0-9]').hasMatch(lastName)) {
        _isLastNameValid = false;
        _lastNameErrorText = 'Last name cannot contain numbers';
      } else {
        _isLastNameValid = true;
        _lastNameErrorText = '';
      }
    });
  }

  void _validateUserName(String lastName) {
    setState(() {
      _isUsernameValid = lastName.isNotEmpty;
      _usernameErrorText = _isUsernameValid ? '' : 'Username must not be empty';
    });
  }

  void _validateEmail(String email) {
    setState(() {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (email.isEmpty) {
        _isEmailValid = false;
        _emailErrorText = 'Email cannot be empty';
      } else if (!emailRegex.hasMatch(email)) {
        _isEmailValid = false;
        _emailErrorText = 'Enter a valid email address';
      } else {
        _isEmailValid = true;
        _emailErrorText = '';
      }
    });
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
      _isPasswordValid = password.length >= 8;
      _passwordErrorText =
          _isPasswordValid ? '' : 'Password must be at least 8 characters';
    });
  }

  void _handleSignup() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final userName = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final phoneNumber = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    _validateEmail(email);
    _validateFirstName(firstName);
    _validateLastName(lastName);
    _validateUserName(userName);
    _validatePhoneNumber(phoneNumber);
    _validatePassword(password);

    if (!_isFirstNameValid ||
        !_isLastNameValid ||
        !_isUsernameValid ||
        !_isEmailValid ||
        !_isPhoneValid ||
        !_isPasswordValid) {
      return;
    }

    final token = await ref.read(fcmServiceProvider).getToken();
    print("FCM Token: $token");

    if (token != null) {
      await ref
          .read(authProvider.notifier)
          .signup(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            gender: _selectedGender,
            firebaseToken: token,
            dob: _formatDate(_selectedDate),
            username: _usernameController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
          );
    } else {
      // Handle case where token is null
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not get device token'),
          backgroundColor: Colors.red,
        ),
      );
    }

    // Call the signup method from your auth provider
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.read(routerProvider);
    ref.listen<AuthState>(authProvider, (_, state) {
      state.maybeWhen(
        authenticated: (user) async {
          try {
            final socketService = ref.read(socketServiceProvider);
            await socketService.connect();
            print("Socket connected after login");
          } catch (e) {
            print("Socket connection error: $e");
            // Don't block navigation if socket fails
          }
          // Navigate on successful login
          // ref.read(routerProvider).push("/main");
          ref.read(routerProvider).push("/categories");
        },
        unverified: (_) {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (_) => const VerificationSentScreen()),
          // );
          // router.go("/verify");
          router.go("/login");
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        },
        orElse: () {},
      );
    });

    final isLoading = ref
        .watch(authProvider)
        .maybeWhen(loading: () => true, orElse: () => false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(children: [
                 
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        AppLocalizations.of(context)!.createAccount,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          // color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.getStarted,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF7B7B7B),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Center(
                      child: Text(
                        '👋',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          AppLocalizations.of(
                                            context,
                                          )!.firstName,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      _isFirstNameValid
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
                                  controller: _firstNameController,
                                  onChanged: _validateFirstName,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'John',
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 15,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color:
                                          _isFirstNameValid
                                              ? Color(0xFF7B7B7B)
                                              : AppColors.error,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              if (!_isFirstNameValid)
                                Text(
                                  _firstNameErrorText,
                                  style: TextStyle(
                                    color: AppColors.error,
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.lastName,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              // Text(
                              //   ' *',
                              //   style: TextStyle(
                              //     fontSize: 14,
                              //     color: Colors.red,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      _isLastNameValid
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
                                  controller: _lastNameController,
                                  onChanged: _validateLastName,
                                  decoration: InputDecoration(
                                    hintText: 'Doe',

                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 15,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              if (!_isLastNameValid)
                                Text(
                                  _lastNameErrorText,
                                  style: TextStyle(
                                    color: AppColors.error,
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Username',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            _isUsernameValid
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
                        controller: _usernameController,
                        onChanged: _validateUserName,
                        decoration: InputDecoration(
                          hintText: 'John21',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color:
                                _isUsernameValid
                                    ? Color(0xFF7B7B7B)
                                    : AppColors.error,
                          ),
                        ),
                      ),
                    ),
                    if (!_isUsernameValid) SizedBox(height: 8),
                    Text(
                      _usernameErrorText,
                      style: TextStyle(color: AppColors.error, fontSize: 12),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.emailAddress,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            _isEmailValid
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
                        controller: _emailController,
                        onChanged: _validateEmail,
                        decoration: InputDecoration(
                          hintText: 'example@email.com',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color:
                                _isEmailValid
                                    ? Color(0xFF7B7B7B)
                                    : AppColors.error,
                          ),
                        ),
                      ),
                    ),
                    if (!_isEmailValid) SizedBox(height: 8),
                    if (!_isEmailValid)
                      Text(
                        _emailErrorText,
                        style: TextStyle(color: AppColors.error, fontSize: 12),
                      ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          AppLocalizations.of(context)!.gender,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Theme(
                                  data: Theme.of(
                                    context,
                                  ).copyWith(canvasColor: Color(0xFFF5F5F5)),
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedGender,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 15,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.wc,
                                        color: Color(0xFF7B7B7B),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color(0xFF7B7B7B),
                                    ),
                                    dropdownColor: Colors.white,
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(12),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'male',
                                        child: Text(
                                          'Male',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'female',
                                        child: Text(
                                          'Female',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      // DropdownMenuItem(
                                      //   value: 'other',
                                      //   child: Text(
                                      //     'Other',
                                      //     style: TextStyle(
                                      //      color: Colors.black,
                                      //       fontSize: 16,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          AppLocalizations.of(
                                            context,
                                          )!.dateOfBirth,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () => _selectDate(context),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 15,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: Color(0xFF7B7B7B),
                                          size: 20,
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          _formatDate(_selectedDate),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
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
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!.phoneNumber,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Color(0xFF7B7B7B),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ],
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
                        decoration: InputDecoration(
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
                      style: TextStyle(color: AppColors.error, fontSize: 12),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.password,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
                          hintText: 'Create a password',
                          hintStyle: TextStyle(color: Color(0xFF9B9B9B)),
                        ),
                      ),
                    ),
                    if (!_isPasswordValid) SizedBox(height: 8),
                    Text(
                      _passwordErrorText,
                      style: TextStyle(color: AppColors.error, fontSize: 12),
                    ),
                    SizedBox(height: 20),

                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _getLegalInfo(context),
                      child: RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.termsAgreement,
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF7B7B7B),
                          ),
                          children: [
                            TextSpan(
                              text:
                                  AppLocalizations.of(context)!.termsAndPrivacy,
                              style: TextStyle(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _handleSignup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child:
                            isLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                )
                                : Text(
                                  AppLocalizations.of(context)!.signUp,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: isLoading ? null : _handleSignup,
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Color(0xFF2B2D5A),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     elevation: 0,
                    //   ),
                    //   child:
                    //       isLoading
                    //           ? const CircularProgressIndicator(
                    //             color: Colors.white,
                    //             strokeWidth: 2,
                    //           )
                    //           : Text(
                    //             'Sign up',
                    //             style: TextStyle(
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.w500,
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    // ),
                    //  SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.alreadyHaveAccount,
                          style: TextStyle(
                            color: Color(0xFF7B7B7B),
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            //   Navigator.pushNamed(context, '/login');
                            router.go("/login");
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
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

  // Future<void> _launchURL() async {
  //   final Uri url = Uri.parse('https://www.navithera.com/privacy');
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url, mode: LaunchMode.externalApplication);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  Future<void> _getLegalInfo(BuildContext context) async {
    final Uri url = Uri.parse('https://www.navithera.com/privacy');

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        _showErrorDialog(context, 'Could not open the link');
      }
    } catch (e) {
      _showErrorDialog(context, 'Something went wrong');
    }
  }
}
