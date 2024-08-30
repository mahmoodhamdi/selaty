import 'package:flutter/material.dart';
import 'package:selaty/features/home/presentation/widgets/search_and_filter.dart';
import 'package:selaty/features/home/presentation/widgets/user_info.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        UserInfo(),
        SearchAndFilter(),
      ],
    );
  }
}
