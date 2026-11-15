import 'package:flutter/material.dart';

class ResultStudentRow extends StatelessWidget {
  final String roll;
  final String name;
  final String quran;
  final String akaid;
  final String arabic1;
  final String arabic2;
  final String bangla;
  final String english;
  final String math;
  final String ict;
  final String total;
  final String grade;
  final String merit;

  const ResultStudentRow({
    super.key,
    required this.roll,
    required this.name,
    required this.quran,
    required this.akaid,
    required this.arabic1,
    required this.arabic2,
    required this.bangla,
    required this.english,
    required this.math,
    required this.ict,
    required this.total,
    required this.grade,
    required this.merit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      child: Row(
        children: [
          _DataCell(roll, width: 50),
          _DataCell(name, width: 160, isBold: true),
          _DataCell(quran, width: 75),
          _DataCell(akaid, width: 75),
          _DataCell(arabic1, width: 75),
          _DataCell(arabic2, width: 75),
          _DataCell(bangla, width: 75),
          _DataCell(english, width: 75),
          _DataCell(math, width: 75),
          _DataCell(ict, width: 65),
          _DataCell(total, width: 70, isBold: true),
          _DataCell(grade, width: 70, isBold: true),
          _DataCell(merit, width: 60),
        ],
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  final double width;
  final bool isBold;

  const _DataCell(
      this.text, {
        required this.width,
        this.isBold = false,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF333333),
          fontSize: 12,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}