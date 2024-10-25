import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/common/widgets/custom_text_field.dart';
import 'package:selaty/core/constants/colors.dart';

class SearchAndFilter extends StatefulWidget {
  const SearchAndFilter({
    super.key,
  });

  @override
  State<SearchAndFilter> createState() => _SearchAndFilterState();
}

class _SearchAndFilterState extends State<SearchAndFilter> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 50, // Adjust the width as needed
            height: 50, // Adjust the height as needed
            decoration: BoxDecoration(
              color: primaryRed,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  // Your onPressed logic here
                },
                iconSize: 24, // Adjust the icon size as needed
                icon: const Icon(
                  FontAwesomeIcons.sliders,
                  color: Colors.white,
                ),
                color: Colors.black, // Set the icon color
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: CustomTextField(
                  keyboardType: TextInputType.name,
                  text: 'البحث',
                  prefixIcon: IconButton(
                      onPressed: () {
                        _searchController.clear();
                      },
                      icon: const Icon(
                        FontAwesomeIcons.xmark,
                        color: Colors.black,
                        size: 12,
                      )),
                  suffixIcon: IconButton(
                      onPressed: () {
                        // Your onPressed logic here
                      },
                      icon: const Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.grey,
                        size: 18,
                      )),
                  width: double.infinity,
                  controller: _searchController),
            ),
          ),
        ],
      ),
    );
  }
}
