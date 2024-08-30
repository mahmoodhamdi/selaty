import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/widgets/profile_grid_view_item.dart';

class ProfileGridView extends StatelessWidget {
  const ProfileGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) => const ProfileGridViewItem(),
      ),
    );
  }
}
