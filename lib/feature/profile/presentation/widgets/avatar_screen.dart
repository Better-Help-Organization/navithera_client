import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navithera_client/core/notification/file_upload_service.dart';
//import 'package:navithera_client/core/network/file_upload_service.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:navithera_client/l10n/app_localizations.dart";
import 'package:navithera_client/core/util/avatar_util.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/auth/presentation/providers/auth_provider.dart';
import 'package:navithera_client/feature/auth/presentation/providers/user_provider.dart';

class AvatarScreen extends ConsumerStatefulWidget {
  const AvatarScreen({super.key});

  @override
  ConsumerState<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends ConsumerState<AvatarScreen> {
  int _selectedAvatar = 0;
  File? _selectedImage;
  bool _isLoading = false;
  bool _isUploading = false;

  // Define avatar options locally
  final List<String> _avatarOptions = [
    'assets/images/avatars/generic_img_01.jpg',
    'assets/images/avatars/generic_img_02.jpg',
    'assets/images/avatars/generic_img_03.jpg',
    'assets/images/avatars/generic_img_04.jpg',
    'assets/images/avatars/generic_img_05.jpg',
    'assets/images/avatars/generic_img_06.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _initializeAvatar();
  }

  void _initializeAvatar() {
    final user = ref.read(currentUserProvider);
    setState(() {
      _selectedAvatar = user?.avatar ?? 0;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _selectedAvatar =
            -1; // Reset avatar selection when custom image is chosen
      });
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_selectedImage != null) {
        // Upload custom image directly from the screen
        setState(() {
          _isUploading = true;
        });

        // Upload the file directly
        final filename = await FileUploadService.uploadProfilePicture(
          _selectedImage!,
        );

        print('File uploaded successfully: $filename');

        final request = UpdateProfilePicRequest(avatar: 7);
        await ref.read(authProvider.notifier).updateProfilePic(request);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Avatar updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else if (_selectedAvatar >= 0) {
        // Use predefined avatar - use the existing repository method
        final request = UpdateProfilePicRequest(
          avatar: _selectedAvatar,
          // profile: "",
        );
        await ref.read(authProvider.notifier).updateProfilePic(request);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Avatar updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.updateProfile,
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
            const SizedBox(height: 32),

            // Profile image display
            Stack(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                    ),
                    child: ClipOval(
                      child:
                          _selectedImage != null
                              ? Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                              )
                              : Image.asset(
                                getAvatarImage(_selectedAvatar),
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const Icon(Icons.person, size: 60),
                              ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                if (_isUploading)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _pickImage,
              child: Text(
                'Upload from gallery',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 24),

            // Virtual avatar selection section
            const Text(
              'Or select a virtual avatar instead',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 24),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: _avatarOptions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAvatar = index;
                      _selectedImage = null;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            _selectedAvatar == index
                                ? AppColors.primary
                                : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(_avatarOptions[index]),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    (_selectedImage != null || _selectedAvatar >= 0) &&
                            !_isLoading
                        ? _updateProfile
                        : null,
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
                          AppLocalizations.of(context)!.saveChanges,
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
    );
  }
}
