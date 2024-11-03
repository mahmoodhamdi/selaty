import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/presentation/logic/profile/get_profile_cubit.dart';
import 'package:selaty/features/home/presentation/logic/profile/get_profile_state.dart';
import 'package:selaty/features/home/presentation/logic/update_profile/update_profile_cubit.dart';
import 'package:selaty/features/home/presentation/views/profile_view.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetProfileCubit>().fetchProfile();
    return BlocBuilder<GetProfileCubit, GetProfileState>(
      builder: (context, state) {
        // Show loading or error message based on the state
        if (state.status == ProfileStatus.failure) {
          return Text(state.errorMessage ?? 'Error loading user data');
        }

        final userData = state.profileData;

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
                                  create: (context) => sl<GetProfileCubit>(),
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
                    radius: 40,
                    backgroundColor: Colors.orange,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: userData != null
                            ? "${ApiConstants.imageUrl}${userData.profilePhotoPath}"
                            : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
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
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData != null ? userData.name : "",
                    style: Styles.textStyle16,
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
