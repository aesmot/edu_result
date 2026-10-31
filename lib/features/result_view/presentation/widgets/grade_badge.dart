
import 'package:flutter/material.dart';

class GradeBadge extends StatelessWidget {
  final String grade;

  const GradeBadge({
    super.key,
    required this.grade,
  });

  Color get _backgroundColor {
    switch (grade) {
      case 'A+':
        return const Color(0xFFE1F7EC);
      case 'A':
        return const Color(0xFFE5F0FF);
      case 'A-':
        return const Color(0xFFFFF0D9);
      case 'F':
        return const Color(0xFFFFE5E5);
      default:
        return const Color(0xFFF0F2F6);
    }
  }

  Color get _textColor {
    switch (grade) {
      case 'A+':
        return const Color(0xFF168653);
      case 'A':
        return const Color(0xFF2463C5);
      case 'A-':
        return const Color(0xFF9A6500);
      case 'F':
        return const Color(0xFFC62828);
      default:
        return const Color(0xFF555C75);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        grade,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: _textColor,
        ),
      ),
    );
  }
}
