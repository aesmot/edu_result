import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../teacher/dashboard/provider/teacher_class_provider.dart';
import '../../../../teacher/dashboard/widgets/quick_actions/class_card.dart';
import '../../../../teacher/dashboard/widgets/quick_actions/column_header.dart';


class ClassesSection extends ConsumerWidget {
  final AsyncValue<List<TeacherClass>> classesAsync;
  final ClassCatalog? catalog;
  final bool busy;
  final int? selectedClassId;
  final int? selectedSubjectId;
  final Function(TeacherClass, TeacherSubject) onSelectSubject;
  final Function(TeacherClass, int) onAddSubject;
  final Function(TeacherSubject) onRemoveSubject;
  final Function(TeacherClass) onDeleteClass;
  final VoidCallback onAddClassPressed;

  const ClassesSection({
    super.key,
    required this.classesAsync,
    required this.catalog,
    required this.busy,
    required this.selectedClassId,
    required this.selectedSubjectId,
    required this.onSelectSubject,
    required this.onAddSubject,
    required this.onRemoveSubject,
    required this.onDeleteClass,
    required this.onAddClassPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacherClasses = classesAsync.value ?? const <TeacherClass>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ColumnHeader(title: 'Classes & Subjects'),
        const SizedBox(height: 12),
        classesAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  'ডাটা লোড করতে সমস্যা হয়েছে!\n$error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
                TextButton(
                  onPressed: () => ref.invalidate(teacherClassesProvider),
                  child: const Text('আবার চেষ্টা করুন'),
                ),
              ],
            ),
          ),
          data: (list) {
            if (list.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'কোনো ক্লাস যোগ করা হয়নি। নিচের Add Class চাপুন।',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
              );
            }

            return Column(
              children: list.map((teacherClass) {
                final chosenIds = teacherClass.subjects
                    .map((s) => s.classSubjectId)
                    .toSet();
                final availableSubjects = (catalog?.subjects ?? const [])
                    .where((s) =>
                s.classId == teacherClass.classId &&
                    !chosenIds.contains(s.classSubjectId))
                    .toList();

                return ClassCard(
                  teacherClass: teacherClass,
                  isSelected: selectedClassId == teacherClass.id,
                  selectedSubjectId: selectedSubjectId,
                  availableSubjects: availableSubjects,
                  busy: busy,
                  onSelectSubject: (subject) {
                    onSelectSubject(teacherClass, subject);
                  },
                  onAddSubject: (classSubjectId) =>
                      onAddSubject(teacherClass, classSubjectId),
                  onRemoveSubject: onRemoveSubject,
                  onDeleteClass: () => onDeleteClass(teacherClass),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 4),
        OutlinedButton.icon(
          onPressed: (busy || catalog == null) ? null : onAddClassPressed,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Class'),
        ),
      ],
    );
  }
}