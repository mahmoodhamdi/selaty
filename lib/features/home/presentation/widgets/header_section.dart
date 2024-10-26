import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
 import 'package:selaty/features/auth/presentation/logic/get_cached_user/get_cached_user_cubit.dart';
import 'package:selaty/features/home/presentation/widgets/search_and_filter.dart';
import 'package:selaty/features/home/presentation/widgets/user_info.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocProvider<CachedUserCubit>(
          create: (context) => sl<CachedUserCubit>()..getCachedUser(),
          child: const UserInfo(),
        ),
        const SearchAndFilter(),
      ],
    );
  }
}
