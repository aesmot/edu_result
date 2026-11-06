import 'package:flutter/material.dart';
class ColumnHeader extends StatelessWidget {

  final String title;
  const ColumnHeader({super.key, required this.title});

  @override

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3FE),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFC7D7FE),
          width: 1.2,
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}