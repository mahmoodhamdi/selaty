import 'dart:io';

import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';

class ProfilePicture extends StatelessWidget {
  final void Function()? onTap;
  final File? selectedImage;
  final String? currentPhotoUrl;
  final bool isEditing;

  const ProfilePicture({
    super.key,
    required this.onTap,
    this.selectedImage,
    this.currentPhotoUrl,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: primaryBlue.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[100],
              backgroundImage: selectedImage != null
                  ? FileImage(selectedImage!)
                  : currentPhotoUrl != null
                      ? NetworkImage(currentPhotoUrl!) as ImageProvider
                      : null,
              child: selectedImage == null && currentPhotoUrl == null
                  ? Icon(Icons.person, size: 60, color: Colors.grey[400])
                  : null,
            ),
          ),
          if (isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryBlue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryBlue.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
