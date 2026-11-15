import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:result_management_system/core/constant/app_colors.dart';

class MarkingNoteCard extends StatelessWidget {
  const MarkingNoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFC7D7FE),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Color(0xFF2563EB),
            size: 20,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'MCQ: 25 marks • Theory: 50 marks • Practical: 25 marks',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}