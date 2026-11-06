import 'package:flutter/material.dart';
import '../../../teacher/dashboard/widgets/quick_actions/column_header.dart';
import '../../../teacher/dashboard/widgets/quick_actions/manage_result_card.dart';


class ManageResultsSection extends StatelessWidget {
  final String? selectedClassName;
  final String? selectedSubjectName;
  final VoidCallback onEnterMarks;
  final VoidCallback onViewResults;

  const ManageResultsSection({
    super.key,
    required this.selectedClassName,
    required this.selectedSubjectName,
    required this.onEnterMarks,
    required this.onViewResults,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ColumnHeader(title: 'Manage Results'),
        const SizedBox(height: 12),
        ManageResultCard(
          selectedClassName: selectedClassName,
          selectedSubjectName: selectedSubjectName,
          onEnterMarks: onEnterMarks,
          onViewResults: onViewResults,
        ),
      ],
    );
  }
}