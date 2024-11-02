import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/common/widgets/custom_app_bar.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/auth/presentation/logic/logout/logout_cubit.dart';
import 'package:selaty/features/home/presentation/widgets/logout_box.dart';
import 'package:selaty/features/home/presentation/widgets/profile_info.dart';
import 'package:selaty/features/home/presentation/widgets/profile_util_box_item.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: const Color(0xffFDFDFF),
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: isPortrait ? 50 : 60,
                  ),
                  const ProfileInfo(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocProvider(
                    create: (context) => sl<LogoutCubit>(),
                    child: const LogoutBox(),
                  ),
                  ProfileUtilBoxItem(
                    onTap: () {},
                    color: accentRedText,
                    icon: Icons.delete,
                    title: 'حذف الحساب',
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
