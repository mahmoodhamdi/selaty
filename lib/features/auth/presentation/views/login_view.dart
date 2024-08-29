import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/custom_password_text_field.dart';
import 'package:selaty/core/common/widgets/custom_text_field.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/routes/routes.dart';
import 'package:selaty/core/validators/validator.dart';
import 'package:selaty/features/auth/presentation/widgets/forgot_password_button.dart';
import 'package:selaty/features/auth/presentation/widgets/login_header.dart';
import 'package:selaty/features/auth/presentation/widgets/not_have_account.dart';
import 'package:selaty/features/auth/presentation/widgets/social_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              isPortrait ? 20.0 : constraints.maxWidth / 4;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LoginHeader(),
                    const SizedBox(height: 30),
                    _buildInputFields(width),
                    ForgotPasswordButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.resetPassword);
                      },
                    ),
                    const SizedBox(height: 30),
                    _buildLoginButton(width),
                    const SizedBox(height: 20),
                    const SocialAuth(
                      text: 'أو تسجيل الدخول باستخدام',
                    ),
                    const NotHaveAccount(),
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
          controller: emailController,
          width: width,
          validator: (value) {
            return TValidator.validateEmail(value);
          },
          text: 'عنوان البريد الالكتروني',
        ),
        const SizedBox(height: 10),
        CustomPasswordTextFormField(
          controller: passwordController,
          width: width,
          text: 'كلمة المرور',
        ),
      ],
    );
  }

  Widget _buildLoginButton(double width) {
    return PrimaryButton(
      height: 50,
      text: 'تسجيل الدخول',
      color: primaryGreen,
      onTap: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          Navigator.pushNamed(context, Routes.register);
        }
      },
      width: width,
    );
  }
}
