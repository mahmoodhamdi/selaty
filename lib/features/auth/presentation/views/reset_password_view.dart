import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/custom_text_field.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/core/validators/validator.dart';
import 'package:selaty/features/auth/presentation/views/otp_view.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        Orientation.portrait == MediaQuery.of(context).orientation;
    return Scaffold(
        backgroundColor: const Color(0xffFDFDFF),
        appBar: CustomAppBar(
            onPressed: () {
              Navigator.pop(context);
            },
            title: 'تحقق من البريد الالكتروني'),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isPortrait ? screenWidth * 0.05 : screenWidth * 0.08,
            vertical: isPortrait ? screenWidth * 0.09 : screenWidth * 0.025,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  'لتغيير كلمة المرور الخاصة بك، الرجاء ادخال بريدك الالكتروني',
                  style: Styles.textStyle16.copyWith(color: Colors.grey),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  text: 'البريد الالكتروني',
                  validator: TValidator.validateEmail,
                  width: double.infinity,
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                Text(
                  'سيتم إرسال رمز التحقق إلى بريدك الإلكتروني',
                  style: Styles.textStyle14.copyWith(color: Colors.grey[600]),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 40),
                PrimaryButton(
                  text: 'إرسال رمز التحقق',
                  color: primaryGreen,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      THelperFunctions.showSnackBar(
                          context: context, message: "تم ارسال رمز التحقق");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpView(
                                    email: emailController.text,
                                  )));
                    }
                  },
                  width: double.infinity, // Adjust width as needed
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Navigate back to login page
                    Navigator.pop(context);
                  },
                  child: Text(
                    'العودة إلى تسجيل الدخول',
                    style: Styles.textStyle16.copyWith(color: primaryGreen),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
