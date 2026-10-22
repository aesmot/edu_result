import 'package:flutter/material.dart';

class GradientActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isPrimary; // প্রাইমারি নাকি সেকেন্ডারি তা নির্ধারণ করবে

  const GradientActionButton({
    super.key,
    required this.text,
    required this.icon,
    this.onPressed,
    this.isPrimary = true, // ডিফল্টভাবে প্রাইমারি বাটন হবে
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          // Primary হলে নীল গ্র্যাডিয়েন্ট, না হলে হালকা সবুজ ব্যাকগ্রাউন্ড
          gradient: isPrimary
              ? const LinearGradient(
            colors: [Color(0xFF4A80F0), Color(0xFF7042F0)],
          )
              : null,
          color: isPrimary ? null : const Color(0xFFEEFAF2),
          borderRadius: BorderRadius.circular(30),
          border: isPrimary
              ? null
              : Border.all(color: const Color(0xFFA2E8C2), width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isPrimary ? Colors.white : const Color(0xFF0F9755),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isPrimary ? Colors.white : const Color(0xFF0F9755),
              ),
            ),
          ],
        ),
      ),
    );
  }
}