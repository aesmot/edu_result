import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class AuthFooter extends StatelessWidget {
  final String titleText;     // Jemon: "Don't have an account? " ba "Already have an account? "
  final String actionText;    // Jemon: "Sign Up" ba "Login"
  final VoidCallback onTap;   // Click korle ki kaj korbe

  const AuthFooter({
    super.key,
    required this.titleText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          titleText,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: const TextStyle(
              color: AppColors.authText, // Apnar app er text color
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}