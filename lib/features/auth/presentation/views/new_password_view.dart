import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/custom_password_text_field.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/features/auth/presentation/views/password_changed_successfully.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key, required this.email});

  final String email;

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitNewPassword() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == _confirmPasswordController.text) {
        _formKey.currentState!.save();
        THelperFunctions.showSnackBar(
            context: context, message: 'تم تغيير كلمة المرور بنجاح');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const PasswordChangedSuccessfullyView()));
      } else {
        THelperFunctions.showSnackBar(
            context: context, message: 'كلمة المرور غير متطابقة');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFDFDFF),
      appBar: CustomAppBar(
          onPressed: () {
            Navigator.pop(context);
          },
          title: 'تعيين كلمة مرور جديدة'),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isPortrait
                    ? 20.w
                    : 20.w, // Use ScreenUtil for horizontal padding
                vertical: 20.h, // Use ScreenUtil for vertical padding
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'الرجاء إدخال كلمة المرور الجديدة',
                      style: Styles.textStyle16.copyWith(color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 40.h), // Use ScreenUtil for spacing
                    CustomPasswordTextFormField(
                      text: 'كلمة المرور الجديدة',
                      width: double.infinity,
                      controller: _passwordController,
                    ),
                    SizedBox(height: 20.h), // Use ScreenUtil for spacing
                    CustomPasswordTextFormField(
                      text: 'تأكيد كلمة المرور الجديدة',
                      width: double.infinity,
                      controller: _confirmPasswordController,
                    ),
                    SizedBox(height: 40.h), // Use ScreenUtil for spacing
                    PrimaryButton(
                      text: 'تعيين كلمة المرور الجديدة',
                      color: primaryGreen,
                      onTap: _submitNewPassword,
                      width: double.infinity,
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
