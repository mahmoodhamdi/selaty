import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/home/presentation/logic/profile/get_profile_cubit.dart';
import 'package:selaty/features/home/presentation/widgets/user_info.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetProfileCubit>(
      create: (context) => sl<GetProfileCubit>(),
      child: const UserInfo(),
    );
  }
}
