import 'package:flutter/material.dart';
import 'package:selaty/core/constants/styles.dart';

class SectionsHeader extends StatelessWidget {
  const SectionsHeader({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        title,
        style: Styles.textStyle18,
      ),
    );
  }
}
