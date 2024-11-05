import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/password_text_field.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/features/auth/data/models/change_password_req_body.dart';
import 'package:selaty/features/auth/presentation/logic/set_new_password/set_new_password_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/set_new_password/set_new_password_state.dart';
import 'package:selaty/features/auth/presentation/views/password_changed_successfully.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key, required this.otp, required this.token});

  final int otp;
  final String token;

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // Responsive sizing
    final horizontalPadding = size.width * (isPortrait ? 0.05 : 0.1);
    final verticalPadding = size.height * 0.03;
    final spacing = size.height * 0.02;
    final largeSpacing = size.height * 0.04;

    return BlocListener<SetNewPasswordCubit, SetNewPasswordState>(
      listener: (context, state) {
        if (state.status == SetNewPasswordStatus.success) {
          THelperFunctions.showSnackBar(
            type: SnackBarType.success,

              context: context, message: "تم تغيير كلمة المرور بنجاح");
          Future.delayed(const Duration(microseconds: 500));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const PasswordChangedSuccessfullyView()),
          );
        }
        if (state.status == SetNewPasswordStatus.failure) {
          THelperFunctions.showSnackBar(
              type: SnackBarType.error,
              context: context, message: state.message!);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffFDFDFF),
        appBar: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: 'تعيين كلمة مرور جديدة',
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
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
                    SizedBox(height: largeSpacing),
                    PasswordTextFormField(
                      text: 'كلمة المرور الجديدة',
                      width: double.infinity,
                      controller: _passwordController,
                    ),
                    SizedBox(height: spacing),
                    PasswordTextFormField(
                      text: 'تأكيد كلمة المرور الجديدة',
                      width: double.infinity,
                      controller: _confirmPasswordController,
                    ),
                    SizedBox(height: largeSpacing),
                    BlocBuilder<SetNewPasswordCubit, SetNewPasswordState>(
                      builder: (context, state) {
                        return PrimaryButton(
                          text: state.status == ForgetPasswordStatus.loading
                              ? 'جاري تعيين كلمة المرور الجديدة ...'
                              : 'تعيين كلمة المرور الجديدة',
                          color: primaryGreen,
                          onTap: () {
                            if (state.status != ForgetPasswordStatus.loading &&
                                _formKey.currentState!.validate()) {
                              THelperFunctions.hideKeyboard(context);

                              if (_passwordController.text ==
                                  _confirmPasswordController.text) {
                                _formKey.currentState!.save();
                                context
                                    .read<SetNewPasswordCubit>()
                                    .setNewPassword(ChangePasswordReqBody(
                                        otp: widget.otp.toString(),
                                        token: widget.token,
                                        newPassword:
                                            _passwordController.text.trim(),
                                        confirmPassword:
                                            _confirmPasswordController.text
                                                .trim()));
                              } else {
                                THelperFunctions.showSnackBar(
            type: SnackBarType.error,

                                    context: context,
                                    message: 'كلمة المرور غير متطابقة');
                              }
                            }
                          },
                          width: double.infinity,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
