import 'package:flutter/material.dart';

class BestValueItem extends StatelessWidget {
  const BestValueItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          width: 330,
          child: Image.asset(
            'assets/images/fruits_category.jpg',
            fit: BoxFit.cover,
          )),
    );
  }
}
