import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';

class OrderInfoCard extends StatelessWidget {
  final Size size;
  final bool isPortrait;

  const OrderInfoCard({
    super.key,
    required this.size,
    required this.isPortrait,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Row(
          children: [
            CircleAvatar(
              radius: isPortrait ? size.width * 0.08 : size.height * 0.08,
              backgroundColor: Colors.white,
              child: Image.asset(
                "assets/images/delivery.png",
                fit: BoxFit.contain,
                color: Colors.black,
                height: isPortrait ? size.width * 0.1 : size.height * 0.1,
              ),
            ),
            SizedBox(width: size.width * 0.05),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "رقم الطلب #123456789",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          isPortrait ? size.width * 0.048 : size.height * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    "تاريخ الطلب : 12/12/2022",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize:
                          isPortrait ? size.width * 0.038 : size.height * 0.025,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
