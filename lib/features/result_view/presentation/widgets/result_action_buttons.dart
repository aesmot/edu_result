
import 'package:flutter/material.dart';
import 'package:result_management_system/core/constant/app_colors.dart';

class ResultActionButtons extends StatelessWidget {
  const ResultActionButtons({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.primaryGradientStart,
                AppColors.primaryGradientEnd,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12), // Apnar preferred radius
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGradientEnd.withValues(alpha: 0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, // Background transparent rakhte hobe
              shadowColor: Colors.transparent,     // Default shadow remove korar jonno
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Download PDF Sheet',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () => _showMessage(
            context,
            'Edit Marks navigation will be connected later.',
          ),
          icon: const Icon(Icons.edit_outlined),
          label: const Text('Edit Marks'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF5B61D6),
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 15,
            ),
            side: const BorderSide(
              color: Color(0xFF5B61D6),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
          ),
        ),
      ],
    );
  }
}
