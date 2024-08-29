import 'package:flutter/material.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/custom_password_text_field.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/core/routes/routes.dart';

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
        Navigator.pushReplacementNamed(
            context, Routes.passwordChangedSuccessfullyView);
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
      appBar: const CustomAppBar(title: 'تعيين كلمة مرور جديدة'),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;
          final screenSize = MediaQuery.of(context).size;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isPortrait ? 20 : screenSize.width * 0.15,
                vertical: screenSize.height * 0.05,
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
                    const SizedBox(height: 40),
                    CustomPasswordTextFormField(
                      text: 'كلمة المرور الجديدة',
                      width: double.infinity,
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 20),
                    CustomPasswordTextFormField(
                      text: 'تأكيد كلمة المرور الجديدة',
                      width: double.infinity,
                      controller: _confirmPasswordController,
                    ),
                    const SizedBox(height: 40),
                    PrimaryButton(
                      height: 60,
                      text: 'تعيين كلمة المرور الجديدة',
                      color: primaryGreen,
                      onTap: _submitNewPassword,
                      width: screenSize.width,
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