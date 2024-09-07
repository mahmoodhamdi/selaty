import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/custom_password_text_field.dart';
import 'package:selaty/core/common/widgets/custom_text_field.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/validators/validator.dart';
import 'package:selaty/features/auth/presentation/views/login_view.dart';
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
    final isPortrait =
        Orientation.portrait == MediaQuery.of(context).orientation;
    final screenWidth = MediaQuery.of(context).size.width;
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
                  const RegisterHeader(),
                  SizedBox(
                      height: isPortrait ? 20 : 10), // Make height responsive
                  _buildInputFields(),
                  SizedBox(
                      height: isPortrait ? 20 : 10), // Make height responsive
                  _buildSignUpButton(),
                  SizedBox(
                      height: isPortrait ? 20 : 10), // Make height responsive
                  const SocialAuth(
                    text: 'أو اشترك بواسطة',
                  ),
                  const AlreadyHaveAccount(),
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
          controller: nameController,
          width: double.infinity,
          text: 'الاسم',
          validator: (value) {
            return TValidator.validateName(value);
          },
        ),
        const SizedBox(height: 10), // Make height responsive
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

  Widget _buildSignUpButton() {
    return PrimaryButton(
      text: 'اشتراك',
      color: primaryGreen,
      onTap: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginView()));
        }
      },
    );
  }
}
