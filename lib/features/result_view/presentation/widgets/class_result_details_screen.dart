
import 'package:flutter/material.dart';
import 'package:result_management_system/shared/widgets/app_bar.dart';

import '../../../../shared/widgets/section_heading.dart';
import '../widgets/teacher_result_list_table.dart';

class ClassResultDetailsScreen extends StatelessWidget {
  final String className;

  const ClassResultDetailsScreen({
    super.key,
    required this.className,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserAppBar(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeading(
                    title: '$className STUDENT RESULTS',
                    icon: Icons.menu_book_rounded,
                  ),
                  const SizedBox(height: 16),

                  const ResultListTable(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
