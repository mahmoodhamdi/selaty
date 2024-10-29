import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade200, // Light flat background
          borderRadius: BorderRadius.circular(30), // Rounded corners
          border: Border.all(
              color: Colors.grey.shade400), // Thin border for modern look
        ),
        child: Row(
          children: [
            // Clear button
            IconButton(
              onPressed: () {
                _searchController.clear();
              },
              icon: const Icon(
                FontAwesomeIcons.xmark,
                color: Colors.black54,
                size: 18,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            // Search input field
            Expanded(
              child: TextFormField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'البحث',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenWidth < 400 ? 12.0 : 16.0,
                    horizontal: 8.0,
                  ),
                ),
                style: TextStyle(
                  fontSize: screenWidth < 400 ? 14 : 16,
                  color: Colors.black87,
                ),
              ),
            ),
            // Search icon button
            IconButton(
              onPressed: () {
                // Your search action logic here
              },
              icon: const Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.black54,
                size: 18,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ],
        ),
      ),
    );
  }
}
