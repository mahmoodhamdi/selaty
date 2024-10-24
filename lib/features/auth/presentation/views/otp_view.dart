import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/features/auth/presentation/views/new_password_view.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key, required this.email});
  final String email;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // Responsive sizing
    final baseSize = size.width * (isPortrait ? 0.17 : 0.1);
    final pinFieldSize = baseSize.clamp(50.0, 70.0);
    final horizontalPadding = size.width * (isPortrait ? 0.04 : 0.09);
    final verticalPadding = size.height * (isPortrait ? 0.04 : 0.07);

    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () => Navigator.pop(context),
        title: 'التحقق من البريد الالكتروني',
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "برجاء ادخال رمز التحقق الخاص بك هنا",
                  style: Styles.textStyle16.copyWith(
                    color: const Color(0xFF333333),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(12),
                      fieldHeight: pinFieldSize,
                      fieldWidth: pinFieldSize,
                      activeFillColor: primaryGreen.withOpacity(0.1),
                      inactiveFillColor: Colors.white,
                      selectedFillColor: primaryGreen.withOpacity(0.2),
                      activeColor: primaryGreen,
                      inactiveColor: const Color(0xFF757575),
                      selectedColor: primaryGreen,
                      errorBorderColor: primaryRed,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    controller: _otpController,
                    onCompleted: (v) => _handleOtpSubmit(v),
                    onChanged: (value) => debugPrint(value),
                    beforeTextPaste: (text) => true,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'لم يصل الكود ؟',
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF757575),
                  ),
                  textAlign: TextAlign.right,
                ),
                GestureDetector(
                  onTap: _resendOtp,
                  child: Text(
                    'إعادة إرسال رمز جديد',
                    style: Styles.textStyle16.copyWith(
                      color: primaryGreen,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                PrimaryButton(
                  text: 'تأكيد',
                  color: primaryGreen,
                  onTap: () => _handleOtpSubmit(_otpController.text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleOtpSubmit(String otp) {
    if (otp == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => NewPasswordView(email: widget.email)),
      );
    } else {
      THelperFunctions.showSnackBar(
          context: context, message: 'الكود غير صحيح');
    }
  }

  void _resendOtp() {
    THelperFunctions.showSnackBar(
      context: context,
      message: 'تم ارسال رمز جديد',
    );
  }
}
