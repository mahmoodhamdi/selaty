import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final IconData icon;
  final String title;
  final Color textColor;

  const ActionButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.icon,
    required this.title,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
