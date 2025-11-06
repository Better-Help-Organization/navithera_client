import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/auth/presentation/providers/auth_provider.dart';
import 'package:navithera_client/feature/auth/presentation/providers/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class UpdatePersonalDetails extends ConsumerStatefulWidget {
  const UpdatePersonalDetails({super.key});

  @override
  ConsumerState<UpdatePersonalDetails> createState() =>
      _UpdatePersonalDetailsState();
}

class _UpdatePersonalDetailsState extends ConsumerState<UpdatePersonalDetails> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();

  String? _genderSelection = 'Male';
  bool _isLoading = false;
  bool _hasShownSuccessMessage = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final user = ref.read(currentUserProvider);
    if (user != null) {
      _firstNameController.text = user.firstName;
      _lastNameController.text = user.lastName;
      _emailController.text = user.email;
      _phoneController.text = user.phoneNumber ?? '';
      _usernameController.text = user.username ?? '';
      _genderSelection =
          user.gender?.isNotEmpty == true
              ? user.gender![0].toUpperCase() + user.gender!.substring(1)
              : 'Male';
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _hasShownSuccessMessage = false;
    });

    final request = UpdateProfileRequest(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      username: _usernameController.text.trim(),
      gender: _genderSelection?.toLowerCase(),
    );

    await ref.read(authProvider.notifier).updateProfile(request);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isShown = false;
    // Listen to auth state changes for success/error messages
    ref.listen<AuthState>(authProvider, (previous, next) {
      next.maybeWhen(
        authenticated: (user) {
          // Show success message if we just updated
          if (!_hasShownSuccessMessage && _isLoading && isShown == false) {
            _hasShownSuccessMessage = true;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Profile Updated"),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.pop(context);
            isShown = true;
          }
        },
        error: (message) {
          print("Error message: $message");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        },
        profileError: (user, message) {
          isShown = true;
          print("Error message: $message");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
          // Navigate to main or stay on the same page
          // ref.read(routerProvider).go('/main');
        },

        orElse: () {},
      );
    });

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with "Personal Details" and a close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.personalDetails,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // First Name and Last Name fields in a row
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: AppLocalizations.of(context)!.firstName,
                      controller: _firstNameController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: AppLocalizations.of(context)!.lastName,
                      controller: _lastNameController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Email Address field
              _buildTextField(
                label: AppLocalizations.of(context)!.emailAddress,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Username field
              _buildTextField(
                label: 'Username',
                controller: _usernameController,
              ),
              const SizedBox(height: 16),

              // Phone Number field
              _buildTextField(
                label: AppLocalizations.of(context)!.phoneNumber,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                max: 9,
                prefix: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 15),
                      Row(
                        children: [
                          const Text('🇪🇹', style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 10),
                          Text(
                            '+251',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Gender identity selection
              _buildChoiceSection(
                label: AppLocalizations.of(context)!.identifyAs,
                options: const ['Male', 'Female'],
                selectedOption: _genderSelection,
                onSelected: (value) {
                  setState(() {
                    _genderSelection = value;
                  });
                },
              ),
              const SizedBox(height: 32),

              // Update Profile button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      _isLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : Text(
                            AppLocalizations.of(context)!.updateProfile,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build text form fields to reduce code duplication
  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    TextInputType? keyboardType,
    Widget? prefix,
    int? max,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: max,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: prefix,
          ),
        ),
      ],
    );
  }

  // Helper method to build the choice chip sections
  Widget _buildChoiceSection({
    required String label,
    required List<String> options,
    required String? selectedOption,
    required ValueChanged<String> onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12.0,
          children:
              options.map((option) {
                final isSelected = selectedOption == option;
                return ChoiceChip(
                  label: Text(option),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      onSelected(option);
                    }
                  },
                  backgroundColor: Colors.grey[200],
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                  avatar:
                      isSelected
                          ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          )
                          : null,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
