import 'package:flutter/material.dart';
import 'package:selaty/core/constants/styles.dart';

class SeeAllWidget extends StatelessWidget {
  const SeeAllWidget({
    super.key,
    required this.title,
    this.onTap,
    this.subTitle = '',
  });
  final String title;
  final String subTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.textStyle18,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            subTitle,
            style: Styles.textStyle12,
          ),
          const Spacer(),
          GestureDetector(
            onTap: onTap,
            child: const Text(
              ' ➤ مشاهدة الكل',
              style: Styles.textStyle12,
            ),
          ),
        ],
      ),
    );
  }
}
