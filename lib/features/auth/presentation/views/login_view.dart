import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/custom_password_text_field.dart';
import 'package:selaty/core/common/widgets/custom_text_field.dart';
import 'package:selaty/core/common/widgets/horizontal_logo.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/validators/validator.dart';
import 'package:selaty/features/auth/presentation/views/reset_password_view.dart';
import 'package:selaty/features/auth/presentation/widgets/forgot_password_button.dart';
import 'package:selaty/features/auth/presentation/widgets/not_have_account.dart';
import 'package:selaty/features/auth/presentation/widgets/social_auth.dart';
import 'package:selaty/features/home/presentation/views/main_view.dart';

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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
        backgroundColor: const Color(0xffFDFDFF),
        appBar: CustomAppBar(
          backgroundColor: const Color(0xffFDFDFF),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isPortrait ? screenWidth / 12 : screenWidth / 10),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HorizontalLogo(),
                  const SizedBox(height: 30), // Make height responsive
                  _buildInputFields(),
                  ForgotPasswordButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResetPasswordView()));
                    },
                  ),
                  const SizedBox(height: 30), // Make height responsive
                  _buildLoginButton(),
                  const SizedBox(height: 20), // Make height responsive
                  const SocialAuth(
                    text: 'أو تسجيل الدخول باستخدام',
                  ),
                  const NotHaveAccount(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          width: double.infinity,
          validator: (value) {
            return TValidator.validateEmail(value);
          },
          text: 'عنوان البريد الالكتروني',
        ),
        const SizedBox(height: 10), // Make height responsive
        CustomPasswordTextFormField(
          controller: passwordController,
          width: double.infinity,
          text: 'كلمة المرور',
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return PrimaryButton(
      height: isPortrait ? screenWidth / 7 : 60,
      width: double.infinity,
      text: 'تسجيل الدخول',
      color: primaryGreen,
      onTap: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainView()));
        }
      },
    );
  }
}
