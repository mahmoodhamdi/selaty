import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/common/widgets/custom_text_field.dart';
import 'package:selaty/core/common/widgets/password_confirm_field.dart';
import 'package:selaty/core/common/widgets/password_text_field.dart';
import 'package:selaty/core/common/widgets/primary_button.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/core/helpers/helper_functions.dart';
import 'package:selaty/core/helpers/location_helper.dart';
import 'package:selaty/core/validators/validator.dart';
import 'package:selaty/features/auth/data/models/register_req_body.dart';
import 'package:selaty/features/auth/domain/usecases/register_usecase.dart';
import 'package:selaty/features/auth/presentation/logic/login/login_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/register/register_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/register/register_state.dart';
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
  final formKey = GlobalKey<FormState>();
  String? fetchedAddress;

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  Future<void> getCurrentLocation() async {
    String? address =
        await LocationHelper.getAddressFromCurrentLocation(context);
    if (address != null && mounted) {
      setState(() {
        fetchedAddress = address;
      });
    } else if (mounted) {
      getCurrentLocation();
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

    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status == RegisterStatus.success) {
          THelperFunctions.showSnackBar(
              context: context, message: state.message);

          Future.delayed(const Duration(microseconds: 500));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => sl<LoginCubit>(),
                      child: const LoginView(),
                    )),
          );
        }
        if (state.status == RegisterStatus.failure) {
          THelperFunctions.showSnackBar(
              context: context, message: state.message);
        }
      },
      child: Scaffold(
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
                  Column(
                    children: [
                      CustomTextField(
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        width: double.infinity,
                        text: 'الاسم',
                        validator: TValidator.validateName,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
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
                        keyboardType: TextInputType.phone,

                        controller: mobileController,
                        width: double.infinity,
                        text: 'رقم الجوال',
                        // validator: TValidator.validatePhoneNumber,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        text: state.status == RegisterStatus.loading
                            ? 'جاري الاشتراك...'
                            : 'اشتراك',
                        color: primaryGreen,
                        onTap: () {
                          if (state.status != RegisterStatus.loading &&
                              formKey.currentState!.validate()) {
                            THelperFunctions.hideKeyboard(context);

                            // Trigger registration
                            final registerCubit = context.read<RegisterCubit>();
                            registerCubit.register(RegisterParams(
                              registerReqBody: RegisterReqBody(
                                  address: fetchedAddress ?? "",
                                  confirmPassword:
                                      cPasswordController.text.trim(),
                                  email: emailController.text.trim(),
                                  mobile: mobileController.text.trim(),
                                  name: nameController.text.trim(),
                                  password: passwordController.text.trim()),
                            ));
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const SocialAuth(text: 'أو اشترك بواسطة'),
                  const AlreadyHaveAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
