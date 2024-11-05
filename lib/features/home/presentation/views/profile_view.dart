import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/features/auth/data/models/update_profile_request_model.dart';
import 'package:selaty/features/home/data/models/get_profile_response.dart';
import 'package:selaty/features/home/domain/usecases/update_profile_usecase.dart';
import 'package:selaty/features/home/presentation/logic/profile/get_profile_cubit.dart';
import 'package:selaty/features/home/presentation/logic/profile/get_profile_state.dart';
import 'package:selaty/features/home/presentation/logic/update_profile/update_profile_cubit.dart';
import 'package:selaty/features/home/presentation/views/main_view.dart';
import 'package:selaty/features/home/presentation/widgets/action_button.dart';
import 'package:selaty/features/home/presentation/widgets/profile_picture.dart';
import 'package:selaty/features/home/presentation/widgets/profile_text_field.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  File? _selectedImage;
  bool _isEditing = false;
  bool _isLoading = false;
  String? _currentPhotoUrl;

  @override
  void initState() {
    super.initState();
    context.read<GetProfileCubit>().fetchProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  void _initializeUserData(ProfileData userData) {
    _nameController.text = userData.name;
    _emailController.text = userData.email;
    _mobileController.text = userData.mobile;
    _currentPhotoUrl = "${ApiConstants.imageUrl}${userData.profilePhotoPath}";
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() => _selectedImage = File(image.path));
      }
    } catch (e) {
      THelperFunctions.showSnackBar(
          type: SnackBarType.error,
        context: context, message: e.toString());
    }
  }

  Future<void> _handleUpdateProfile() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_selectedImage == null && _currentPhotoUrl == null) {
      THelperFunctions.showSnackBar(
        type: SnackBarType.info,
        context: context,
        message: 'يجب أختيار صورة لتحديث الملف الشخصي.',
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final params = UpdateProfileUsecaseParams(
        request: UpdateProfileRequest(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          mobile: _mobileController.text.trim(),
        ),
        profilePhoto: _selectedImage!,
      );

      await context.read<UpdateProfileCubit>().updateProfile(params);
    } catch (e) {
      THelperFunctions.showSnackBar(
        type: SnackBarType.error,
        context: context, message: e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: primaryBlue),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainView()),
            ),
          ),
          actions: [
            if (!_isLoading)
              IconButton(
                icon: Icon(
                  _isEditing ? Icons.save_rounded : Icons.edit_rounded,
                  color: primaryBlue,
                ),
                onPressed: () {
                  if (_isEditing) {
                    _handleUpdateProfile();
                  }
                  setState(() => _isEditing = !_isEditing);
                },
              ),
          ],
          title: const Text('الملف الشخصي'),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          )),
      body: BlocBuilder<GetProfileCubit, GetProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ProfileStatus.success &&
              state.profileData != null) {
            _initializeUserData(state.profileData!);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  ProfilePicture(
                    onTap: _isEditing ? _pickImage : null,
                    selectedImage: _selectedImage,
                    currentPhotoUrl: _currentPhotoUrl,
                    isEditing: _isEditing,
                  ),
                  const SizedBox(height: 32),
                  ProfileTextField(
                    controller: _nameController,
                    label: 'الاسم',
                    enabled: _isEditing,
                    prefixIcon: Icons.person_outline,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'الاسم مطلوب';
                      if (value!.length < 2) {
                        return 'يجب أن يكون الاسم على الأقل حرفين';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ProfileTextField(
                    controller: _emailController,
                    label: 'البريد الإلكتروني',
                    enabled: _isEditing,
                    prefixIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'البريد الإلكتروني مطلوب';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value!)) {
                        return 'أدخل بريد إلكتروني صحيح';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ProfileTextField(
                    controller: _mobileController,
                    label: 'رقم الجوال',
                    enabled: _isEditing,
                    prefixIcon: Icons.phone_outlined,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'رقم الجوال مطلوب';
                      if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value!)) {
                        return 'أدخل رقم جوال صحيح';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  if (!_isEditing) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ActionButton(
                          onTap: () {
                            // Navigate to Edit Profile logic (toggle editing state)
                            setState(() {
                              _isEditing = !_isEditing;
                            });
                          },
                          color: secondaryPurple.withOpacity(0.1),
                          icon: Icons.edit_rounded,
                          title: _isEditing ? 'حفظ' : 'تعديل الملف الشخصي',
                          textColor: secondaryPurple,
                        ),
                        ActionButton(
                          onTap: () {
                            // Handle logout
                          },
                          color: primaryRed.withOpacity(0.1),
                          icon: Icons.logout_rounded,
                          title: 'تسجيل خروج',
                          textColor: secondaryPurple,
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
