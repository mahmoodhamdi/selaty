import 'package:flutter/material.dart';

class UserCartView extends StatelessWidget {
  const UserCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("لا توجد منتجات في السلة"),
      ),
    );
  }
}
