import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/auth/data/models/update_profile_request_model.dart';
import 'package:selaty/features/auth/presentation/logic/logout/logout_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/logout/logout_state.dart';
import 'package:selaty/features/auth/presentation/views/auth_view.dart';
import 'package:selaty/features/home/data/models/get_profile_response.dart';
import 'package:selaty/features/home/domain/usecases/update_profile_usecase.dart';
import 'package:selaty/features/home/presentation/logic/profile/get_profile_cubit.dart';
import 'package:selaty/features/home/presentation/logic/profile/get_profile_state.dart';
import 'package:selaty/features/home/presentation/logic/update_profile/update_profile_cubit.dart';
import 'package:selaty/features/home/presentation/logic/update_profile/update_profile_state.dart';

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
    context.read<GetProfileCubit>().fetchProfile(context);
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
      _showErrorSnackBar('فشل في اختيار الصورة. حاول مرة أخرى.');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: accentRedText,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: primaryGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleUpdateProfile() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_selectedImage == null && _currentPhotoUrl == null) {
      _showErrorSnackBar('الرجاء اختيار صورة الملف الشخصي');
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
      _showErrorSnackBar('فشل تحديث الملف الشخصي. حاول مرة أخرى.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<LogoutCubit>()),
          BlocProvider(create: (context) => sl<UpdateProfileCubit>()),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<UpdateProfileCubit, UpdateProfileState>(
              listener: (context, state) {
                if (state.status == UpdateProfileStatus.success) {
                  _showSuccessSnackBar('تم تحديث الملف الشخصي بنجاح!');
                  setState(() => _isEditing = false);
                  context.read<GetProfileCubit>().fetchProfile(context);
                } else if (state.status == UpdateProfileStatus.failure) {
                  _showErrorSnackBar(state.message ?? 'فشل التحديث');
                }
              },
            ),
            BlocListener<GetProfileCubit, GetProfileState>(
              listener: (context, state) {
                if (state.status == ProfileStatus.success &&
                    state.profileData != null) {
                  _initializeUserData(state.profileData!);
                } else if (state.status == ProfileStatus.failure) {
                  _showErrorSnackBar(
                      state.errorMessage ?? 'فشل في تحميل بيانات المستخدم');
                }
              },
            ),
          ],
          child: BlocBuilder<GetProfileCubit, GetProfileState>(
            builder: (context, state) {
              if (state.status == ProfileStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryBlue),
                  ),
                );
              }

              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: _isEditing ? _pickImage : null,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: primaryBlue.withOpacity(0.2),
                                      width: 2,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.grey[100],
                                    backgroundImage: _selectedImage != null
                                        ? FileImage(_selectedImage!)
                                        : _currentPhotoUrl != null
                                            ? NetworkImage(_currentPhotoUrl!)
                                                as ImageProvider
                                            : null,
                                    child: _selectedImage == null &&
                                            _currentPhotoUrl == null
                                        ? Icon(Icons.person,
                                            size: 60, color: Colors.grey[400])
                                        : null,
                                  ),
                                ),
                                if (_isEditing)
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: primaryBlue,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: primaryBlue.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          _buildTextField(
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
                          _buildTextField(
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
                          _buildTextField(
                            controller: _mobileController,
                            label: 'رقم الجوال',
                            enabled: _isEditing,
                            prefixIcon: Icons.phone_outlined,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'رقم الجوال مطلوب';
                              }
                              if (!RegExp(r'^\+?[\d\s-]{10,}$')
                                  .hasMatch(value!)) {
                                return 'أدخل رقم جوال صحيح';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),
                          if (!_isEditing) ...[
                            Row(
                              children: [
                                BlocListener<LogoutCubit, LogoutState>(
                                  listener: (context, state) {
                                    if (state.status == LogoutStatus.success) {
                                      Future.delayed(
                                          const Duration(seconds: 1));
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AuthView()),
                                      );
                                    }
                                  },
                                  child: Expanded(
                                    child: _buildActionButton(
                                      onTap: () =>
                                          context.read<LogoutCubit>().logout(),
                                      color: secondaryPurple.withOpacity(0.1),
                                      icon: Icons.logout_rounded,
                                      title: 'تسجيل خروج',
                                      textColor: secondaryPurple,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildActionButton(
                                    onTap: () {
                                      // Handle delete account
                                    },
                                    color: accentRedText.withOpacity(0.1),
                                    icon: Icons.delete_outline_rounded,
                                    title: 'حذف الحساب',
                                    textColor: accentRedText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  if (_isLoading)
                    Container(
                      color: Colors.black12,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(primaryBlue),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // [Previous _buildTextField and _buildActionButton methods remain the same]
}

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required bool enabled,
  required IconData prefixIcon,
  required String? Function(String?) validator,
}) {
  return TextFormField(
    controller: controller,
    enabled: enabled,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: enabled ? primaryBlue : Colors.grey,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: enabled ? primaryBlue : Colors.grey,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryBlue.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentRedText),
      ),
      filled: true,
      fillColor: enabled ? Colors.white : Colors.grey[50],
    ),
  );
}

Widget _buildActionButton({
  required VoidCallback onTap,
  required Color color,
  required IconData icon,
  required String title,
  required Color textColor,
}) {
  return Material(
    color: color,
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
