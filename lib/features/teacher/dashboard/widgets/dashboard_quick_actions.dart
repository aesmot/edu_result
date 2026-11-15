import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../examination/domain/models/examination_model.dart';
import '../../../mark_entry/presentation/screens/mark_entry_screen.dart';
import '../../../mark_entry/presentation/widgets/classes_sec/classes_section.dart';
import '../../../result_view/presentation/providers/selected_class_subject_provider.dart';
import '../../../result_view/presentation/screens/teacher_result_screen.dart';
import '../../../result_view/presentation/widgets/manage_results_section.dart';
import '../provider/teacher_class_provider.dart';

class DashboardQuickActions extends ConsumerWidget {
  final ExaminationModel? selectedExam;

  const DashboardQuickActions({
    super.key,
    required this.selectedExam,
  });

  void _showMessage(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
      ),
    );
  }

  String _errorText(Object? error) {
    final text = error.toString().replaceFirst('Exception: ', '');
    if (text.contains('23505')) return 'এটি আগেই যোগ করা হয়েছে';
    return 'সমস্যা হয়েছে!\n$text';
  }

  void _report(BuildContext context, WidgetRef ref, bool success, String successMessage) {
    if (success) {
      _showMessage(context, successMessage);
    } else {
      _showMessage(
        context,
        _errorText(ref.read(teacherClassControllerProvider).error),
        isError: true,
      );
    }
  }

  Future<void> _showAddClassDialog(BuildContext context, WidgetRef ref, List<ClassOption> available, List<TeacherClass> teacherClasses) async {
    if (available.isEmpty) {
      _showMessage(context, 'সব ক্লাস আগেই যোগ করা হয়েছে');
      return;
    }

    int? chosen;
    final result = await showDialog<int>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: const Text('ক্লাস যোগ করুন'),
          content: DropdownButton<int>(
            isExpanded: true,
            value: chosen,
            hint: const Text('ক্লাস বাছুন'),
            items: available
                .map((c) => DropdownMenuItem<int>(
              value: c.id,
              child: Text(c.name),
            ))
                .toList(),
            onChanged: (value) => setLocal(() => chosen = value),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('বাতিল'),
            ),
            FilledButton(
              onPressed: chosen == null ? null : () => Navigator.pop(ctx, chosen),
              child: const Text('যোগ করুন'),
            ),
          ],
        ),
      ),
    );

    if (result == null) return;
    final ok = await ref
        .read(teacherClassControllerProvider.notifier)
        .addClass(result);
    _report(context, ref, ok, 'ক্লাস যোগ হয়েছে');
  }

  Future<void> _deleteClass(BuildContext context, WidgetRef ref, TeacherClass teacherClass) async {
    final confirmed = await _confirm(
      context: context,
      title: 'ক্লাস মুছবেন?',
      message: '${teacherClass.className} ও এর সব বিষয় তালিকা থেকে মুছে যাবে।',
    );
    if (confirmed != true) return;

    final ok = await ref
        .read(teacherClassControllerProvider.notifier)
        .removeClass(teacherClass.id);

    if (ok && ref.read(selectedClassIdProvider) == teacherClass.id) {
      ref.read(selectedClassIdProvider.notifier).state = null;
      ref.read(selectedSubjectIdProvider.notifier).state = null;
    }
    _report(context, ref, ok, 'ক্লাস মুছে ফেলা হয়েছে');
  }

  Future<void> _addSubject(BuildContext context, WidgetRef ref, TeacherClass teacherClass, int classSubjectId) async {
    final ok = await ref
        .read(teacherClassControllerProvider.notifier)
        .addSubject(
      teacherClassId: teacherClass.id,
      classSubjectId: classSubjectId,
    );
    _report(context, ref, ok, 'বিষয় যোগ হয়েছে');
  }

  Future<void> _removeSubject(BuildContext context, WidgetRef ref, TeacherSubject subject) async {
    final ok = await ref
        .read(teacherClassControllerProvider.notifier)
        .removeSubject(subject.id);

    if (ok && ref.read(selectedSubjectIdProvider) == subject.id) {
      ref.read(selectedSubjectIdProvider.notifier).state = null;
    }
    _report(context, ref, ok, 'বিষয় মুছে ফেলা হয়েছে');
  }

  Future<bool?> _confirm({required BuildContext context, required String title, required String message}) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('বাতিল'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('মুছে ফেলুন'),
          ),
        ],
      ),
    );
  }

  void _openMarkEntry(BuildContext context, TeacherClass? selectedClass, TeacherSubject? selectedSubject) {
    if (selectedClass == null || selectedSubject == null) {
      _showMessage(context, 'আগে ক্লাস ও বিষয় বাছুন', isError: true);
      return;
    }

    final exam = selectedExam;
    if (exam == null) {
      _showMessage(context, 'আগে পরীক্ষা বাছুন', isError: true);
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MarkEntryScreen(
          examinationId: exam.id,
          examinationName: exam.name,
          academicYear: exam.academicYear,
          className: selectedClass.className,
          subjectName: selectedSubject.name,
          classSubjectId: selectedSubject.classSubjectId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classesAsync = ref.watch(teacherClassesProvider);
    final catalog = ref.watch(classCatalogProvider).value;
    final busy = ref.watch(teacherClassControllerProvider).isLoading;

    final selectedClassId = ref.watch(selectedClassIdProvider);
    final selectedSubjectId = ref.watch(selectedSubjectIdProvider);

    final teacherClasses = classesAsync.value ?? const <TeacherClass>[];
    TeacherClass? selectedClass;
    TeacherSubject? selectedSubject;

    for (final c in teacherClasses) {
      if (c.id == selectedClassId) {
        selectedClass = c;
        for (final s in c.subjects) {
          if (s.id == selectedSubjectId) selectedSubject = s;
        }
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column 1: Classes & Subjects Section
        Expanded(
          flex: 3,
          child: ClassesSection(
            classesAsync: classesAsync,
            catalog: catalog,
            busy: busy,
            selectedClassId: selectedClassId,
            selectedSubjectId: selectedSubjectId,
            /*
            onSelectClass: (teacherClass) {
              if (selectedClassId != teacherClass.id) {
                ref.read(selectedClassIdProvider.notifier).state = teacherClass.id;
                ref.read(selectedSubjectIdProvider.notifier).state = null;
              }
            },
            onSelectSubject: (teacherClass, subject) {
              ref.read(selectedClassIdProvider.notifier).state = teacherClass.id;
              ref.read(selectedSubjectIdProvider.notifier).state = subject.id;
            },*/
            onSelectClass: (teacherClass) {
              final currentId = ref.read(selectedClassIdProvider);
              if (currentId != teacherClass.id) {
                ref.read(selectedClassIdProvider.notifier).state = teacherClass.id;
                ref.read(selectedClassNameProvider.notifier).state = teacherClass.className;

                // ক্লাস চেঞ্জ হলে সাবজেক্ট খালি করে দিন
                ref.read(selectedSubjectIdProvider.notifier).state = null;
                ref.read(selectedSubjectNameProvider.notifier).state = null;
                ref.read(selectedClassSubjectIdProvider.notifier).state = null;
              }
            },
            onSelectSubject: (teacherClass, subject) {
              // ক্লাস সেভ
              ref.read(selectedClassIdProvider.notifier).state = teacherClass.id;
              ref.read(selectedClassNameProvider.notifier).state = teacherClass.className;

              // সাবজেক্ট সেভ (নাম ও classSubjectId সহ)
              ref.read(selectedSubjectIdProvider.notifier).state = subject.id;
              ref.read(selectedSubjectNameProvider.notifier).state = subject.name; // <--- এটি নিশ্চিত করবে নাম রেজাল্ট ভিউতে যাবে
              ref.read(selectedClassSubjectIdProvider.notifier).state = subject.classSubjectId;
            },



            onAddSubject: (teacherClass, classSubjectId) =>
                _addSubject(context, ref, teacherClass, classSubjectId),
            onRemoveSubject: (subject) => _removeSubject(context, ref, subject),
            onDeleteClass: (teacherClass) => _deleteClass(context, ref, teacherClass),
            onAddClassPressed: () {
              final addedClassIds =
              teacherClasses.map((c) => c.classId).toSet();
              final available = catalog!.classes
                  .where((c) => !addedClassIds.contains(c.id))
                  .toList();
              _showAddClassDialog(context, ref, available, teacherClasses);
            },
          ),
        ),

        const SizedBox(width: 12),

        // Column 2: Manage Results Section
        Expanded(
          flex: 2,
          child: ManageResultsSection(
            selectedClassName: selectedClass?.className,
            selectedSubjectName: selectedSubject?.name,
            onEnterMarks: () => _openMarkEntry(context, selectedClass, selectedSubject),
            onViewResults: () {
              final exam = selectedExam;

              if (exam == null ||
                  selectedClass == null ||
                  selectedSubject == null) {
                _showMessage(
                  context,
                  'আগে পরীক্ষা, ক্লাস ও বিষয় বাছুন',
                  isError: true,
                );
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TeacherResultScreen(
                    examName: exam.name,
                    academicYear: exam.academicYear.toString(),
                    className: selectedClass!.className,
                    subjectName: selectedSubject!.name,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}