import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/custom_text_field.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/core/routes/routes.dart';
import 'package:selaty/core/validators/validator.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xffFDFDFF),
      appBar: const CustomAppBar(title: 'تحقق من البريد الالكتروني'),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;
          final screenSize = MediaQuery.of(context).size;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isPortrait ? 20.w : screenSize.width * 0.15,
                vertical: 20.h,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'لتغيير كلمة المرور الخاصة بك، الرجاء ادخال بريدك الالكتروني',
                      style: Styles.textStyle16.copyWith(color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 40.h),
                    CustomTextField(
                      text: 'البريد الالكتروني',
                      validator: TValidator.validateEmail,
                      width: double.infinity,
                      controller: emailController,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'سيتم إرسال رمز التحقق إلى بريدك الإلكتروني',
                      style:
                          Styles.textStyle14.copyWith(color: Colors.grey[600]),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 40.h),
                    PrimaryButton(
                      text: 'إرسال رمز التحقق',
                      color: primaryGreen,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          THelperFunctions.showSnackBar(
                              context: context, message: "تم ارسال رمز التحقق");
                          Navigator.pushReplacementNamed(
                              context, Routes.otpView,
                              arguments: emailController.text);
                        }
                      },
                      width: double.infinity, // Adjust width as needed
                    ),
                    SizedBox(height: 20.h),
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
            ),
          );
        },
      ),
    );
  }
}
