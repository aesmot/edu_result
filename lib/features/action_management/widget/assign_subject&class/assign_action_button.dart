
import 'package:flutter/material.dart';

class AssignActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isLoading;

  const AssignActionButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isPrimary
              ? const Color(0xFF2563EB)
              : Colors.white,
          foregroundColor: isPrimary
              ? Colors.white
              : const Color(0xFF475569),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isPrimary
                ? BorderSide.none
                : const BorderSide(
              color: Color(0xFFCBD5E1),
            ),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
