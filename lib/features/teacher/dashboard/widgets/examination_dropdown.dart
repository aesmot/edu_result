import 'package:flutter/material.dart';

class ExaminationDropdown extends StatefulWidget {
  const ExaminationDropdown({super.key});

  @override
  State<ExaminationDropdown> createState() =>
      _ExaminationDropdownState();
}

class _ExaminationDropdownState extends State<ExaminationDropdown> {
  String? selectedExamination;

  final List<String> examinations = [
    'First Term Examination',
    'Half Yearly Examination',
    'Annual Examination',
    'Model Test Examination',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Examination',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: selectedExamination,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: 'Choose an examination',
            filled: true, // ব্যাকগ্রাউন্ড রঙ কাজ করার জন্য এটি true করতে হবে
            fillColor: Colors.blue.shade50, // হালকা ব্লু ব্যাকগ্রাউন্ড
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            // সাধারণ অবস্থায় বর্ডার
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade200, width: 1.5),
            ),
            // ফোকাস বা সিলেক্ট থাকা অবস্থায় বর্ডার
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            // মাউস বা সাধারণ অবস্থায় বর্ডার (enabledBorder)
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade200, width: 1.5),
            ),
          ),
          items: examinations.map((exam) {
            return DropdownMenuItem<String>(
              value: exam,
              child: Text(exam),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedExamination = value;
            });
          },
        ),
      ],
    );
  }
}