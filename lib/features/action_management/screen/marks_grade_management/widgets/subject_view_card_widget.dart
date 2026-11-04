import 'package:flutter/material.dart';
import 'package:result_management_system/core/constant/app_colors.dart';

class SubjectViewCardWidget extends StatelessWidget {
  final String subjectName;
  final String subtitle;
  final VoidCallback onTap;
  final VoidCallback onEditPressed;

  const SubjectViewCardWidget({
    super.key,
    required this.subjectName,
    required this.subtitle,
    required this.onTap,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.cardBorder,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.menu_book_rounded,
                    color: AppColors.primaryGradientStart,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subjectName,
                      style: const TextStyle(
                        color: Color(0xFF1E293B),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // এই এডিট আইকনে ক্লিক করলেই এডিট মোড অন হয়ে যাবে
              IconButton(
                icon: const Icon(
                  Icons.edit_rounded,
                  size: 16,
                  color: AppColors.primaryGradientStart,
                ),
                onPressed: onEditPressed,
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.primaryGradientEnd,
              ),
            ],
          ),
        ),
      ),
    );
  }
}