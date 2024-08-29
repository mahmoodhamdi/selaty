import 'package:flutter/material.dart';

class AdWidget extends StatelessWidget {
  const AdWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      width: MediaQuery.sizeOf(context).width,
      height: 180,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Image.asset(
        'assets/images/fruits_img.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
