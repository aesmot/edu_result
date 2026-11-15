import 'package:flutter/material.dart';

class StudentMarksUI {
  final int studentId;
  final String name;
  final String roll; // সুনির্দিষ্টভাবে roll রাখা হলো
  final TextEditingController mcqController;
  final TextEditingController theoryController;
  final TextEditingController practicalController;
  int totalMarks;

  StudentMarksUI({
    required this.studentId,
    required this.name,
    required this.roll,
    String initialMcq = '',
    String initialTheory = '',
    String initialPractical = '', required String theory, required String practical, required String mcq,
  })  : mcqController = TextEditingController(text: initialMcq),
        theoryController = TextEditingController(text: initialTheory),
        practicalController = TextEditingController(text: initialPractical),
        totalMarks = 0 {
    calculateTotal();

    // ইনপুট পরিবর্তনের সাথে সাথে অটো টোটাল আপডেট করার জন্য
    mcqController.addListener(calculateTotal);
    theoryController.addListener(calculateTotal);
    practicalController.addListener(calculateTotal);
  }

  void calculateTotal() {
    final mcq = int.tryParse(mcqController.text) ?? 0;
    final theory = int.tryParse(theoryController.text) ?? 0;
    final practical = int.tryParse(practicalController.text) ?? 0;

    totalMarks = mcq + theory + practical;
  }

  // স্ক্রিনের সাথে ম্যাচ করার জন্য গেটারগুলো
  int get total => totalMarks;

  bool get isComplete {
    return mcqController.text.isNotEmpty &&
        theoryController.text.isNotEmpty &&
        practicalController.text.isNotEmpty;
  }

  bool get isPending => !isComplete;

  void dispose() {
    mcqController.dispose();
    theoryController.dispose();
    practicalController.dispose();
  }
}