import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../examination/domain/models/examination_model.dart';
import '../../../mark_entry/presentation/screens/mark_entry_screen.dart';

import '../../../mark_entry/presentation/widgets/classes_sec/classes_section.dart';
import '../../../result_view/presentation/screens/teacher_result_screen.dart';
import '../../../result_view/presentation/widgets/manage_results_section.dart';
import '../provider/teacher_class_provider.dart';


class DashboardQuickActions extends ConsumerStatefulWidget {
  final ExaminationModel? selectedExam;

  const DashboardQuickActions({
    super.key,
    required this.selectedExam,
  });

  @override
  ConsumerState<DashboardQuickActions> createState() =>
      _DashboardQuickActionsState();
}

class _DashboardQuickActionsState extends ConsumerState<DashboardQuickActions> {
  int? _selectedClassId;
  int? _selectedSubjectId;

  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) return;
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

  void _report(bool success, String successMessage) {
    if (success) {
      _showMessage(successMessage);
    } else {
      _showMessage(
        _errorText(ref.read(teacherClassControllerProvider).error),
        isError: true,
      );
    }
  }

  Future<void> _showAddClassDialog(List<ClassOption> available) async {
    if (available.isEmpty) {
      _showMessage('সব ক্লাস আগেই যোগ করা হয়েছে');
      return;
    }

    int? chosen;
    final result = await showDialog<int>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: const Text('Add Class'),
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
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed:
              chosen == null ? null : () => Navigator.pop(ctx, chosen),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );

    if (result == null) return;
    final ok = await ref
        .read(teacherClassControllerProvider.notifier)
        .addClass(result);
    _report(ok, 'ক্লাস যোগ হয়েছে');
  }

  Future<void> _deleteClass(TeacherClass teacherClass) async {
    final confirmed = await _confirm(
      title: 'ক্লাস মুছবেন?',
      message: '${teacherClass.className} ও এর সব বিষয় তালিকা থেকে মুছে যাবে।',
    );
    if (confirmed != true) return;

    final ok = await ref
        .read(teacherClassControllerProvider.notifier)
        .removeClass(teacherClass.id);

    if (ok && _selectedClassId == teacherClass.id) {
      setState(() {
        _selectedClassId = null;
        _selectedSubjectId = null;
      });
    }
    _report(ok, 'ক্লাস মুছে ফেলা হয়েছে');
  }

  Future<void> _addSubject(
      TeacherClass teacherClass, int classSubjectId) async {
    final ok = await ref
        .read(teacherClassControllerProvider.notifier)
        .addSubject(
      teacherClassId: teacherClass.id,
      classSubjectId: classSubjectId,
    );
    _report(ok, 'বিষয় যোগ হয়েছে');
  }

  Future<void> _removeSubject(TeacherSubject subject) async {
    final ok = await ref
        .read(teacherClassControllerProvider.notifier)
        .removeSubject(subject.id);

    if (ok && _selectedSubjectId == subject.id) {
      setState(() => _selectedSubjectId = null);
    }
    _report(ok, 'বিষয় মুছে ফেলা হয়েছে');
  }

  Future<bool?> _confirm({required String title, required String message}) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _openMarkEntry(
      TeacherClass? selectedClass,
      TeacherSubject? selectedSubject,
      ) {
    if (selectedClass == null || selectedSubject == null) {
      _showMessage('আগে ক্লাস ও বিষয় বাছুন', isError: true);
      return;
    }

    final exam = widget.selectedExam;
    if (exam == null) {
      _showMessage('আগে পরীক্ষা বাছুন', isError: true);
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final classesAsync = ref.watch(teacherClassesProvider);
    final catalog = ref.watch(classCatalogProvider).value;
    final busy = ref.watch(teacherClassControllerProvider).isLoading;

    final teacherClasses = classesAsync.value ?? const <TeacherClass>[];
    TeacherClass? selectedClass;
    TeacherSubject? selectedSubject;
    for (final c in teacherClasses) {
      if (c.id == _selectedClassId) {
        selectedClass = c;
        for (final s in c.subjects) {
          if (s.id == _selectedSubjectId) selectedSubject = s;
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
            selectedClassId: _selectedClassId,
            selectedSubjectId: _selectedSubjectId,
            onSelectSubject: (teacherClass, subject) {
              setState(() {
                _selectedClassId = teacherClass.id;
                _selectedSubjectId = subject.id;
              });
            },
            onAddSubject: (teacherClass, classSubjectId) =>
                _addSubject(teacherClass, classSubjectId),
            onRemoveSubject: _removeSubject,
            onDeleteClass: _deleteClass,
            onAddClassPressed: () {
              final addedClassIds =
              teacherClasses.map((c) => c.classId).toSet();
              final available = catalog!.classes
                  .where((c) => !addedClassIds.contains(c.id))
                  .toList();
              _showAddClassDialog(available);
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
            onEnterMarks: () => _openMarkEntry(selectedClass, selectedSubject),
            onViewResults: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TeacherResultScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}