import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/core/routes/routes.dart';

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
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'التحقق من البريد الالكتروني',
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final isPortrait = orientation == Orientation.portrait;
                final screenWidth = constraints.maxWidth;

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isPortrait ? 20.w : screenWidth * 0.1,
                      vertical: 20.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "برجاء ادخال رمز التحقق الخاص بك هنا",
                            style: Styles.textStyle16.copyWith(
                              color: const Color(0xFF333333),
                              fontWeight: FontWeight.bold,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: PinCodeTextField(
                            appContext: context,
                            length: 4,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(
                                  12.r), // Use r for responsive radius
                              fieldHeight: isPortrait ? 70.h : 90.h,
                              fieldWidth: isPortrait ? 70.w : 40.w,
                              activeFillColor: primaryGreen.withOpacity(0.1),
                              inactiveFillColor: Colors.white,
                              selectedFillColor: primaryGreen.withOpacity(0.2),
                              activeColor: primaryGreen,
                              inactiveColor: const Color(0xFF757575),
                              selectedColor: primaryGreen,
                              errorBorderColor: primaryRed,
                            ),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            backgroundColor: Colors.transparent,
                            enableActiveFill: true,
                            controller: _otpController,
                            onCompleted: (v) {
                              if (v == '1234') {
                                Navigator.pushReplacementNamed(
                                    context, Routes.newPasswordView,
                                    arguments: widget.email);
                              } else {
                                THelperFunctions.showSnackBar(
                                    context: context,
                                    message: 'الكود غير صحيح');
                              }
                            },
                            onChanged: (value) {
                              debugPrint(value);
                            },
                            beforeTextPaste: (text) {
                              return true;
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'لم يصل الكود ؟',
                            style: Styles.textStyle16.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF757575),
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle resend OTP
                            THelperFunctions.showSnackBar(
                              context: context,
                              message: 'تم ارسال رمز جديد',
                            );
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'إعادة إرسال رمز جديد',
                              style: Styles.textStyle16.copyWith(
                                color: primaryGreen,
                                decoration: TextDecoration.underline,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        PrimaryButton(
                          text: 'تأكيد',
                          color: primaryGreen,
                          onTap: () {
                            if (_otpController.text == '1234') {
                              Navigator.pushReplacementNamed(
                                  context, Routes.newPasswordView,
                                  arguments: widget.email);
                            } else {
                              THelperFunctions.showSnackBar(
                                context: context,
                                message: 'الكود غير صحيح',
                              );
                            }
                          },
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
