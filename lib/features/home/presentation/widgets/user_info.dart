import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/auth/presentation/logic/get_cached_user/get_cached_user_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/get_cached_user/get_cached_user_state.dart';
import 'package:selaty/features/home/presentation/logic/update_profile/update_profile_cubit.dart';
import 'package:selaty/features/home/presentation/views/profile_view.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CachedUserCubit, CachedUserState>(
      builder: (context, state) {
        // Show loading or error message based on the state
        if (state.status == CachedUserStatus.loading) {
          return const CircularProgressIndicator();
        } else if (state.status == CachedUserStatus.failure) {
          return Text(state.errorMessage ?? 'Error loading user data');
        }

        final userData = state.userData;
        log('user data: ${userData!.profilePhotoPath}');
        if (userData == null) {
          return const Text('No user data available');
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) => sl<UpdateProfileCubit>(),
                                ),
                                BlocProvider(
                                  create: (context) => sl<CachedUserCubit>(),
                                ),
                              ],
                              child: const ProfileView(),
                            )),
                  );
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.orange,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl:
                            "${ApiConstants.imageUrl}${userData.profilePhotoPath}",
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10), // Add space between avatar and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData.name,
                    style: Styles.textStyle16,
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.white,
                        child: Icon(
                          FontAwesomeIcons.locationDot,
                          color: primaryRed,
                          size: 16,
                        ),
                      ),
                      Text(
                        "",
                        style: Styles.textStyle16.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
