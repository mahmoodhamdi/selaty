import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/custom_text_field.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/core/validators/validator.dart';
import 'package:selaty/features/auth/data/models/forget_password_req_body.dart';
import 'package:selaty/features/auth/presentation/logic/forget_password/forget_password_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/forget_password/forget_password_state.dart';
import 'package:selaty/features/auth/presentation/views/new_password_view.dart';

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
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state.status == ForgetPasswordStatus.success) {
          THelperFunctions.showSnackBar(
              context: context, message: "تم التحقق من البريد الإلكتروني");
          Future.delayed(const Duration(microseconds: 500));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => NewPasswordView(
                      email: state.email,
                    )),
          );
        }
        if (state.status == ForgetPasswordStatus.error) {
          THelperFunctions.showSnackBar(
              context: context, message: state.message!);
        }
      },
      child: Scaffold(
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
                    keyboardType: TextInputType.emailAddress,
                    text: 'البريد الالكتروني',
                    validator: TValidator.validateEmail,
                    width: double.infinity,
                    controller: emailController,
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                      builder: (context, state) {
                    return PrimaryButton(
                      text: state.status == ForgetPasswordStatus.loading
                          ? 'جاري التحقق من البريدالإلكتروني...'
                          : 'تحقق من البريد الإلكتروني',

                      color: primaryGreen,
                      onTap: () {
                        if (state.status != ForgetPasswordStatus.loading &&
                            _formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          context.read<ForgetPasswordCubit>().resetPassword(
                                ForgetPasswordReqBody(
                                  email: emailController.text.trim(),
                                ),
                              );
                        }
                      },
                      width: double.infinity, // Adjust width as needed
                    );
                  }),
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
          )),
    );
  }
}
