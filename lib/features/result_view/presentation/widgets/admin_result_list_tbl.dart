import 'package:flutter/material.dart';
import 'package:result_management_system/core/constant/app_colors.dart';

import 'result_student_row.dart';

class AdminResultListTable extends StatelessWidget {
  const AdminResultListTable({super.key});

  // ৮টি বিষয় এবং অন্যান্য কলাম মিলিয়ে টেবিলের মোট প্রস্থ বাড়িয়ে দেওয়া হয়েছে
  static const double _tableWidth = 1150;

  // মাদরাসা বোর্ডের ৬ষ্ঠ শ্রেণির ৮টি বিষয়সহ ডামি ছাত্র ডেটা
  static final _students = [
    {
      'roll': '01',
      'name': 'Md. Abdullah',
      'quran': '85',
      'akaid': '78',
      'arabic1': '80',
      'arabic2': '82',
      'bangla': '75',
      'english': '88',
      'math': '90',
      'ict': '92',
      'total': '670',
      'grade': 'A+',
      'merit': '01',
    },
    {
      'roll': '02',
      'name': 'Tanvir Hasan',
      'quran': '70',
      'akaid': '65',
      'arabic1': '72',
      'arabic2': '68',
      'bangla': '70',
      'english': '78',
      'math': '80',
      'ict': '85',
      'total': '588',
      'grade': 'A',
      'merit': '02',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // টেবিলের ওপরে এক্সপোর্ট বাটন সেকশন
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  // PDF Export Logic
                },
                icon: const Icon(Icons.picture_as_pdf, size: 16, color: Colors.redAccent),
                label: const Text('Export PDF', style: TextStyle(fontSize: 12)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.cardBorder),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () {
                  // Excel/CSV Export Logic
                },
                icon: const Icon(Icons.table_chart, size: 16, color: Colors.green),
                label: const Text('Export Excel', style: TextStyle(fontSize: 12)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.cardBorder),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),

        // মূল টেবিল কন্টেইনার (উভяমুখী স্ক্রল সুবিধা সহ)
        Expanded(
          child: Container(
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
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: _tableWidth,
                    child: ListView(
                      children: [
                        // টেবিল হেডার
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.tblHeadingStart,
                                AppColors.tblHeadingEnd,
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
                              _HeaderCell('Roll', width: 50),
                              _HeaderCell('Student Name', width: 160),
                              _HeaderCell('Quran', width: 75),
                              _HeaderCell('Akaid', width: 75),
                              _HeaderCell('Ar-I', width: 75),
                              _HeaderCell('Ar-II', width: 75),
                              _HeaderCell('Bangla', width: 75),
                              _HeaderCell('English', width: 75),
                              _HeaderCell('Math', width: 75),
                              _HeaderCell('ICT', width: 65),
                              _HeaderCell('Total', width: 70),
                              _HeaderCell('Grade', width: 70),
                              _HeaderCell('Merit', width: 60),
                            ],
                          ),
                        ),
                        // ছাত্র-ছাত্রীদের রো লিস্ট
                        ..._students.map(
                              (student) => ResultStudentRow(
                            roll: student['roll']!,
                            name: student['name']!,
                            quran: student['quran']!,
                            akaid: student['akaid']!,
                            arabic1: student['arabic1']!,
                            arabic2: student['arabic2']!,
                            bangla: student['bangla']!,
                            english: student['english']!,
                            math: student['math']!,
                            ict: student['ict']!,
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
            ),
          ),
        ),
      ],
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