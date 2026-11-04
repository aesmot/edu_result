import 'package:flutter/material.dart';
import 'package:result_management_system/core/constant/app_colors.dart';
import 'package:result_management_system/features/action_management/screen/marks_grade_management/widgets/subject_Item_card.dart';
import 'package:result_management_system/shared/widgets/app_bar.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({
    super.key,
    required this.classNum,
  });

  final int classNum;

  // Class অনুযায়ী Subject List
  List<String> _getSubjectsForClass(int classNum) {
    if (classNum >= 9) {
      return [
        'Bangla 1st Paper',
        'Bangla 2nd Paper',
        'English 1st Paper',
        'English 2nd Paper',
        'Mathematics',
        'ICT',
        'Physics',
        'Chemistry',
        'Biology',
      ];
    } else {
      return [
        'Bangla',
        'English',
        'Mathematics',
        'Science',
        'ICT',
        'Bangladesh & Global Studies',
        'Islam & Moral Education',
      ];
    }
  }

  // প্রতিটি Subject-এর আলাদা Subtitle
  static const Map<String, String> subjectSubtitles = {
    'Bangla 1st Paper': 'Mcq 25, Written 75 = Total 100',
    'Bangla 2nd Paper': 'Manage Bangla 2nd Paper marks',
    'English 1st Paper': 'Manage English 1st Paper marks',
    'English 2nd Paper': 'Manage English 2nd Paper marks',
    'Mathematics': 'Manage Mathematics marks',
    'ICT': 'Written 50, MCQ  25 Practical  25. Total 100',
    'Physics': 'Manage Physics marks',
    'Chemistry': 'Manage Chemistry marks',
    'Biology': 'Manage Biology marks',
    'Bangla': 'Manage Bangla marks',
    'English': 'Manage English marks',
    'Science': 'Manage Science marks',
    'Bangladesh & Global Studies': 'Manage BGS marks',
    'Islam & Moral Education': 'Manage Islamic Studies marks',
  };

  @override
  Widget build(BuildContext context) {
    final subjects = _getSubjectsForClass(classNum);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: UserAppBar(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subjectName = subjects[index];
                final subtitle = subjectSubtitles[subjectName] ??
                    'Manage marks & student results';

                // প্রতিটা সাবজেক্টের জন্য আলাদা Stateful আইটেম উইজেট কল করা হলো
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SubjectItemCard(
                    subjectName: subjectName,
                    subtitle: subtitle,
                    classNum: classNum,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}