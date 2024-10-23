import 'package:flutter/material.dart';
import 'package:selaty/core/constants/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.backgroundColor = const Color(0xffFDFDFF),
    this.title = '',
    this.titleColor = Colors.black,
    this.onPressed,
  });

  final String title;
  final Color? backgroundColor;
  final Color titleColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
      ),
      actions: [
        const SizedBox(width: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: IconButton(
              onPressed: null,
              icon: Icon(
                Icons.camera_alt_outlined,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const Spacer(),
        Text(
          title,
          style: Styles.textStyle18.copyWith(
            color: titleColor,
          ),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
