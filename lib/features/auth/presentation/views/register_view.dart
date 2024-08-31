import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/custom_password_text_field.dart';
import 'package:selaty/core/common/widgets/custom_text_field.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/routes/routes.dart';
import 'package:selaty/core/validators/validator.dart';
import 'package:selaty/features/auth/presentation/widgets/already_have_account.dart';
import 'package:selaty/features/auth/presentation/widgets/register_header.dart';
import 'package:selaty/features/auth/presentation/widgets/social_auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFDFDFF),
      appBar: const CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isPortrait = constraints.maxWidth < constraints.maxHeight;
          final width =
              isPortrait ? constraints.maxWidth : constraints.maxWidth / 2;
          final horizontalPadding =
              isPortrait ? 20.0.w : constraints.maxWidth / 4;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RegisterHeader(),
                    SizedBox(
                        height:
                            isPortrait ? 20.h : 10.h), // Make height responsive
                    _buildInputFields(width),
                    SizedBox(
                        height:
                            isPortrait ? 20.h : 10.h), // Make height responsive
                    _buildSignUpButton(width),
                    SizedBox(
                        height:
                            isPortrait ? 20.h : 10.h), // Make height responsive
                    const SocialAuth(
                      text: 'أو اشترك بواسطة',
                    ),
                    const AlreadyHaveAccount(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputFields(double width) {
    return Column(
      children: [
        CustomTextField(
          controller: nameController,
          width: width,
          text: 'الاسم',
          validator: (value) {
            return TValidator.validateName(value);
          },
        ),
        SizedBox(height: 10.h), // Make height responsive
        CustomTextField(
          controller: emailController,
          width: width,
          validator: (value) {
            return TValidator.validateEmail(value);
          },
          text: 'عنوان البريد الالكتروني',
        ),
        SizedBox(height: 10.h), // Make height responsive
        CustomPasswordTextFormField(
          controller: passwordController,
          width: width,
          text: 'كلمة المرور',
        ),
      ],
    );
  }

  Widget _buildSignUpButton(double width) {
    return PrimaryButton(
      text: 'اشتراك',
      color: primaryGreen,
      onTap: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          Navigator.pushNamed(context, Routes.login);
        }
      },
      width: width,
    );
  }
}
