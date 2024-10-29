import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';
import 'package:shimmer/shimmer.dart';

class SubCategoriesView extends StatelessWidget {
  final Category category;
  const SubCategoriesView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    List<SubCategory> subCategories = category.subCat;
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
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: subCategories.length,
          itemBuilder: (context, index) {
            return SubCategoryCard(subCategory: subCategories[index]);
          },
        ),
      ),
    );
  }
}

class SubCategoryCard extends StatelessWidget {
  final SubCategory subCategory;

  const SubCategoryCard({
    super.key,
    required this.subCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Handle subcategory tap
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: CachedNetworkImage(
                    imageUrl: "${ApiConstants.imageUrl}${subCategory.img}",
                    fit: BoxFit.fill,
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
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
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
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: secondaryPurple,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (subCategory.details.isNotEmpty)
                          Text(
                            subCategory.details,
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryPurple.withOpacity(0.7),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
