
import 'package:flutter/material.dart';
import 'package:result_management_system/core/constant/app_colors.dart';

import 'result_student_row.dart';

class ResultListTable extends StatelessWidget {
  const ResultListTable({super.key});

  static const double _tableWidth = 690;

  static const List<Map<String, String>> _students = [
    {
      'roll': '01',
      'name': 'Md. Abdullah',
      'total': '84',
      'grade': 'A+',
      'merit': '02',
    },
    {
      'roll': '02',
      'name': 'Tanvir Hasan',
      'total': '73',
      'grade': 'A',
      'merit': '05',
    },
    {
      'roll': '03',
      'name': 'Rayhan Ahmed',
      'total': '97',
      'grade': 'A+',
      'merit': '01',
    },
    {
      'roll': '04',
      'name': 'Nusrat Jahan',
      'total': '63',
      'grade': 'A-',
      'merit': '10',
    },
    {
      'roll': '05',
      'name': 'Shakil Hossain',
      'total': '28',
      'grade': 'F',
      'merit': '--',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: AppColors.cardBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: _tableWidth,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration( // <-- color soriye decoration diben
                    gradient: LinearGradient(
                      colors: [
                        AppColors.tblHeadingStart,
                        AppColors.tblHeadingEnd,
                        //Color(0xFF4C9EEB),
                        //Color(0xFF6B4EE6)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                  child: const Row(
                    children: [
                      _HeaderCell('Roll', width: 48),
                      _HeaderCell('Student Name', width: 180),
                      _HeaderCell('Total', width: 85),
                      _HeaderCell('Grade', width: 95),
                      _HeaderCell('Merit', width: 90),
                    ],
                  ),
                ),
                ..._students.map(
                      (student) => ResultStudentRow(
                    roll: student['roll']!,
                    name: student['name']!,
                    total: student['total']!,
                    grade: student['grade']!,
                    merit: student['merit']!,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String title;
  final double width;

  const _HeaderCell(
      this.title, {
        required this.width,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
