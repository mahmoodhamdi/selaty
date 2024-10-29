import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';
import 'package:shimmer/shimmer.dart';

// Use your app's defined colors here
const Color primaryRed = Color(0xffEF3F4C); // Bright Red
const Color primaryGreen = Color(0xff2AC17E); // Vivid Green
const Color primaryBlue = Color(0xff35A2FF); // Sky Blue

const Color secondaryPurple = Color(0xff736C8B); // Soft Purple
const Color secondaryOlive = Color(0xff859D3F); // Olive Green
const Color secondaryOrange = Color(0xffEB971B); // Warm Orange
const Color secondarySkyBlue = Color(0xff24B4AA); // Teal Blue

const Color accentRedText = Color(0xffE11E24); // Deep Red Text

class SubCategoriesView extends StatelessWidget {
  final Category category;
  const SubCategoriesView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    List<SubCategory> subCategories = category.subCat;
    final orientation = MediaQuery.of(context).orientation;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.name,
          style: const TextStyle(
            color: primaryRed,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: primaryRed),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.04),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double cardWidth =
                orientation == Orientation.portrait ? 180.0 : 220.0;
            final int crossAxisCount =
                (constraints.maxWidth / cardWidth).floor();
            final double childAspectRatio =
                orientation == Orientation.portrait ? 0.8 : 1.2;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    crossAxisCount.clamp(2, 4), // Minimum 2, maximum 4 columns
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: constraints.maxWidth * 0.04,
                mainAxisSpacing: constraints.maxHeight * 0.02,
              ),
              itemCount: subCategories.length,
              itemBuilder: (context, index) {
                return SubCategoryCard(
                  subCategory: subCategories[index],
                  orientation: orientation,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class SubCategoryCard extends StatelessWidget {
  final SubCategory subCategory;
  final Orientation orientation;

  const SubCategoryCard({
    super.key,
    required this.subCategory,
    required this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 400;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16), // More rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 4), // Increased depth for modern look
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Handle subcategory tap
                },
                child: orientation == Orientation.portrait
                    ? _buildPortraitLayout(isSmallScreen)
                    : _buildLandscapeLayout(isSmallScreen),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLandscapeLayout(bool isSmallScreen) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _buildImage(),
        ),
        Expanded(
          flex: 3,
          child: _buildDetails(isSmallScreen),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: "${ApiConstants.imageUrl}${subCategory.img}",
          fit: BoxFit.cover, // Prevents image distortion
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.white,
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[100],
            child: const Icon(
              Icons.error_outline,
              color: primaryRed,
            ),
          ),
        ),
        // Gradient overlay for text readability
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(),
          ),
        ),
      ],
    );
  }

  Widget _buildDetails(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 6 : 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subCategory.name,
            style: TextStyle(
              fontSize: isSmallScreen ? 13 : 15,
              fontWeight: FontWeight.bold,
              color: secondaryPurple, // Using your app's secondary color
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (subCategory.details.isNotEmpty)
            Text(
              subCategory.details,
              style: TextStyle(
                fontSize: isSmallScreen ? 11 : 13,
                color: secondaryPurple.withOpacity(0.7),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }

  Widget _buildPortraitLayout(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
      children: [
        Expanded(
          flex: 3,
          child: Center(
            child: AspectRatio(
              aspectRatio: 1, // To keep the image square and centered
              child: _buildImage(),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: _buildDetails(isSmallScreen),
        ),
      ],
    );
  }
}
