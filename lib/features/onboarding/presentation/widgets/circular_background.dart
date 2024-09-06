import 'package:flutter/material.dart';

class CircularBackground extends StatelessWidget {
  const CircularBackground({
    super.key,
    required this.color,
    required this.image,
  });

  final Color color;
  final String image;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth * 0.15; // 15% of available width
        return Center(
          child: CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            radius: size,
            child: CircleAvatar(
              backgroundColor: color.withOpacity(0.4),
              radius: size * 0.8,
              child: CircleAvatar(
                backgroundColor: color,
                radius: size * 0.6,
                child: SizedBox(
                  width: size * 0.75,
                  child: Image.asset(image),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
