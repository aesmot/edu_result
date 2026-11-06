import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarkingNoteCard extends StatelessWidget {
  const MarkingNoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3FE),
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
                color: Color(0xFF1E40AF),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}