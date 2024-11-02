import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/custom_text_field.dart';
import 'package:selaty/core/common/widgets/horizontal_logo.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/core/validators/validator.dart';
import 'package:selaty/features/auth/data/models/login_req_body.dart';
import 'package:selaty/features/auth/domain/usecases/login_usecase.dart';
import 'package:selaty/features/auth/presentation/logic/forget_password/send_otp_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/login/login_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/login/login_state.dart';
import 'package:selaty/features/auth/presentation/logic/register/register_cubit.dart';
import 'package:selaty/features/auth/presentation/views/verify_email_view.dart';
import 'package:selaty/features/auth/presentation/widgets/forgot_password_button.dart';
import 'package:selaty/features/auth/presentation/widgets/not_have_account.dart';
import 'package:selaty/features/auth/presentation/widgets/social_auth.dart';
import 'package:selaty/features/home/presentation/views/main_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            THelperFunctions.showSnackBar(
                context: context, message: state.message);

            Future.delayed(const Duration(seconds: 1));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => sl<RegisterCubit>(),
                        child: const MainView(),
                      )),
            );
          }
          if (state.status == LoginStatus.failure) {
            THelperFunctions.showSnackBar(
                context: context, message: state.message);
          }
        },
        child: Scaffold(
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
                    horizontal:
                        isPortrait ? screenWidth / 12 : screenWidth / 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HorizontalLogo(),
                      const SizedBox(height: 30), // Make height responsive
                      Column(
                        children: [
                          CustomTextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            width: double.infinity,
                            // validator: (value) {
                            //   return TValidator.validateEmail(value);
                            // },
                            text: 'عنوان البريد الالكتروني',
                          ),
                          const SizedBox(height: 10), // Make height responsive
                          CustomTextField(
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                            controller: passwordController,
                            width: double.infinity,
                            text: 'كلمة المرور',
                          ),
                        ],
                      ),
                      ForgotPasswordButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => sl<SendOtpCubit>(),
                                        child: const VerifyEmailView(),
                                      )));
                        },
                      ),
                      const SizedBox(height: 30), // Make height responsive
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return PrimaryButton(
                            text: state.status == LoginStatus.loading
                                ? 'جاري تسجيل الدخول...'
                                : 'تسجيل الدخول',
                            color: primaryGreen,
                            onTap: () {
                              if (state.status != LoginStatus.loading &&
                                  formKey.currentState!.validate()) {
                                THelperFunctions.hideKeyboard(context);
                                 final loginCubit = context.read<LoginCubit>();
                                loginCubit.login(LoginParms(
                                    loginReqBody: LoginReqBody(
                                  password: passwordController.text.trim(),
                                  phoneEmail: emailController.text.trim(),
                                )));
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20), // Make height responsive
                      const SocialAuth(
                        text: 'أو تسجيل الدخول باستخدام',
                      ),
                      const NotHaveAccount(),
                    ],
                  ),
                ),
              ),
            )));
  }
}
