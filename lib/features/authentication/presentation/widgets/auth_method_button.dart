import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class AuthMethodButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const AuthMethodButton({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(title),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.authText,
        backgroundColor: isSelected
            ? const Color(0xFFFFFFFF)
            : Colors.white,
        side: BorderSide(
          color: isSelected
              ? const Color(0xFF69A8E3)
              : Colors.grey.shade300,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}