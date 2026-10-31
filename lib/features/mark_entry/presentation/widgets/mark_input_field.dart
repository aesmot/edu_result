
import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

/// Reusable input field for entering a student's marks.
///
/// Supports different mark components such as MCQ, Theory, and Practical.
class MarkInputField extends StatelessWidget {
  const MarkInputField({
    super.key,
    required this.controller,
    required this.maxMark,
    required this.onChanged,
    this.enabled = true,
    this.width = 64,
  });

  final TextEditingController controller;
  final int maxMark;
  final ValueChanged<String> onChanged;
  final bool enabled;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: false,
          signed: false,
        ),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: '0',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 13,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 12,
          ),
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey.shade100,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.primaryGradientStart,
              width: 1.5,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
