import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/custom_text_field.dart';
import 'package:selaty/core/common/widgets/password_confirm_field.dart';
import 'package:selaty/core/common/widgets/password_text_field.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/helpers/location_helper.dart';
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
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? fetchedAddress;
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
    mobileController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> getCurrentLocation() async {
    String? address = await LocationHelper.getAddressFromCurrentLocation();

    if (address != null) {
      setState(() {
        fetchedAddress = address;
        addressController.text = address;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffFDFDFF),
      appBar: CustomAppBar(
        backgroundColor: const Color(0xffFDFDFF),
        onPressed: () => Navigator.pop(context),
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
                const SizedBox(height: 20),
                InputFields(
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  cPasswordController: cPasswordController,
                  mobileController: mobileController,
                ),
                const SizedBox(height: 20),
                SignUpButton(formKey: formKey),
                const SizedBox(height: 20),
                const SocialAuth(text: 'أو اشترك بواسطة'),
                const AlreadyHaveAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController cPasswordController;
  final TextEditingController mobileController;

  const InputFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.cPasswordController,
    required this.mobileController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: nameController,
          width: double.infinity,
          text: 'الاسم',
          validator: TValidator.validateName,
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: emailController,
          width: double.infinity,
          text: 'عنوان البريد الالكتروني',
          validator: TValidator.validateEmail,
        ),
        const SizedBox(height: 10),
        PasswordTextFormField(
          controller: passwordController,
          width: double.infinity,
          text: 'كلمة المرور',
        ),
        const SizedBox(height: 10),
        PasswordConfirmField(
          text: "تأكيد كلمة المرور",
          width: double.infinity,
          controller: cPasswordController,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "تأكيد كلمة المرور مطلوب";
            }
            if (value != passwordController.text.trim()) {
              return "لابد من توافق كلمات المرور";
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: mobileController,
          width: double.infinity,
          text: 'رقم الجوال',
          validator: TValidator.validatePhoneNumber,
        ),
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SignUpButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: 'اشتراك',
      color: primaryGreen,
      onTap: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
          );
        }
      },
    );
  }
}
