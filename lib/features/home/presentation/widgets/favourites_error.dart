import 'package:flutter/material.dart';
import 'package:selaty/core/constants/colors.dart';

class FavouritesError extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const FavouritesError({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: primaryRed,
            size: 60,
          ),
          const SizedBox(height: 16),
          Text(
            'خطأ: $errorMessage',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
            ),
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }
}
