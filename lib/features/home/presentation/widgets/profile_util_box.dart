import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/auth/presentation/logic/logout/logout_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/logout/logout_state.dart';
import 'package:selaty/features/auth/presentation/views/auth_view.dart';
import 'package:selaty/features/home/presentation/widgets/profile_util_box_item.dart';

class ProfileUtilBox extends StatelessWidget {
  // profile_util_box.dart
  const ProfileUtilBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state.status == LogoutStatus.success) {
          Future.delayed(const Duration(seconds: 1));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AuthView()),
          );
        }
      },
      child: ProfileUtilBoxItem(
        onTap: () {
          context.read<LogoutCubit>().logout();
        },
        color: primaryGreen,
        icon: Icons.logout,
        title: 'خروج',
      ),
    );
  }
}
