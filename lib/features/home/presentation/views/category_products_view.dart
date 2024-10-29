import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';
import 'package:selaty/features/home/presentation/widgets/product_card.dart';
import 'package:selaty/features/home/presentation/widgets/search_and_filter.dart';

class CategoryProductsView extends StatefulWidget {
  const CategoryProductsView({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  State<CategoryProductsView> createState() => _CategoryProductsViewState();
}

class _CategoryProductsViewState extends State<CategoryProductsView> {
  String? selectedSubCategory;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive grid items count
    int crossAxisCount = isPortrait ? 2 : 4;
    if (screenWidth > 1200) {
      crossAxisCount = 5;
    } else if (screenWidth > 900) {
      crossAxisCount = 4;
    } else if (screenWidth > 600) {
      crossAxisCount = 3;
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Enhanced AppBar with gradient background and shadow
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: primaryGreen,
            pinned: true,
            elevation: 4,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryGreen, secondaryOlive],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            title: Text(
              widget.category.name,
              style: Styles.textStyle18.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // Floating Search Bar and Dropdown with better styling
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  // Floating Search Bar with rounded corners and shadow
                  const Expanded(
                    flex: 3,
                    child: SearchBarWidget(),
                  ),
                  const SizedBox(width: 16),
                  // Enhanced Dropdown with padding and border
                  Expanded(
                    flex: 2,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('كل التصنيفات'),
                        value: selectedSubCategory,
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: Text('كل التصنيفات'),
                          ),
                          ...widget.category.subCat
                              .map<DropdownMenuItem<String>>(
                            (subCat) => DropdownMenuItem(
                              value: subCat.name,
                              child: Text(subCat.name),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedSubCategory = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Improved Product Grid with better spacing and animation
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, subCatIndex) {
                  final subCategory = widget.category.subCat[subCatIndex];

                  // Skip if filtering by subcategory and this isn't the selected one
                  if (selectedSubCategory != null &&
                      selectedSubCategory != subCategory.name.toString()) {
                    return const SizedBox.shrink();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          selectedSubCategory ?? "كل التصنيفات",
                          style: Styles.textStyle18.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 1.4 / 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemCount: 4, // Replace with actual product count
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {},
                          child: const ProductCard(),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
                childCount: widget.category.subCat.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
