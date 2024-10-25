import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/auth/presentation/bloc/get_cached_user/get_cached_user_cubit.dart';
import 'package:selaty/features/auth/presentation/bloc/get_cached_user/get_cached_user_state.dart';
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
        } else if (state.status == CachedUserStatus.error) {
          return Text(state.errorMessage ?? 'Error loading user data');
        }

        final userData = state.userData;
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
                        builder: (context) => const ProfileView()),
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
                        imageUrl: userData.profilePhotoUrl,
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
              const Spacer(),
              Container(
                width: 35.0,
                height: 35.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      // Your onPressed logic here
                    },
                    iconSize: 16,
                    icon: const Icon(Icons.camera_alt_outlined),
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
