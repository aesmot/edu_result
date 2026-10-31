
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/examination_providers.dart';
import '../domain/models/examination.dart';

class ExaminationDropdown extends ConsumerWidget {
  final String? selectedExaminationId;
  final ValueChanged<Examination?> onChanged;

  const ExaminationDropdown({
    super.key,
    required this.selectedExaminationId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('[ExaminationDropdown] build called');
    final examinationsAsync = ref.watch(examinationsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Examination',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        examinationsAsync.when(
          loading: () => const LinearProgressIndicator(),
          error: (error, stackTrace) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Failed to load examinations.'),
              TextButton(
                onPressed: () => ref.invalidate(examinationsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
          data: (examinations) {
            if (examinations.isEmpty) {
              return const Text('No examinations available.');
            }

            final validSelectedId = examinations.any(
                  (exam) => exam.id == selectedExaminationId,
            )
                ? selectedExaminationId
                : null;

            return DropdownButtonFormField<String>(
              value: validSelectedId,
              isExpanded: true,
              decoration: const InputDecoration(
                hintText: 'Choose an examination',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              items: examinations.map((exam) {
                return DropdownMenuItem<String>(
                  value: exam.id,
                  child: Text(
                    '${exam.name} (${exam.academicYear})',
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (id) {
                Examination? selectedExam;

                for (final exam in examinations) {
                  if (exam.id == id) {
                    selectedExam = exam;
                    break;
                  }
                }

                onChanged(selectedExam);
              },
            );
          },
        ),
      ],
    );
  }
}
