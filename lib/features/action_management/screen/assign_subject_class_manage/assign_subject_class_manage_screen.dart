import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:result_management_system/features/action_management/screen/assign_subject_class_manage/providers/assign_subject_provider.dart';
import 'package:result_management_system/shared/widgets/app_bar.dart';

import 'assigned_card_Item.dart';
import 'domain/models/teacher_with_assigned_class.dart';
import 'edit_assign_sub&class_screen.dart';

////

class AssignSubjectClassManageScreen extends ConsumerWidget {
  const AssignSubjectClassManageScreen({super.key});

  Future<void> _confirmDelete(
      BuildContext context,
      WidgetRef ref,
      ClassAssignment cls,
      AssignedSubjectItem subject,
      ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Assignment মুছবেন?'),
        content: Text(
          '"${subject.subjectName}" (${cls.className}) এর assignment সরানো হবে।',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('বাতিল'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('মুছুন'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await ref
          .read(assignSubjectRepositoryProvider)
          .deleteAssignment(subject.assignmentId);
      ref.invalidate(teacherWithAssignmentsProvider);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachersAsync = ref.watch(teacherWithAssignmentsProvider);

    return Scaffold(
      appBar: UserAppBar(),
      body: teachersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ত্রুটি: $error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () =>
                      ref.invalidate(teacherWithAssignmentsProvider),
                  child: const Text('আবার চেষ্টা করুন'),
                ),
              ],
            ),
          ),
        ),
        data: (teachers) {
          return RefreshIndicator(
            onRefresh: () => ref.refresh(teacherWithAssignmentsProvider.future),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'CURRENT ASSIGNED SUBJEC TEACHER',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF64748B),
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 12),
                if (teachers.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'কোনো teacher পাওয়া যায়নি',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                for (var i = 0; i < teachers.length; i++)
                  AssignedCardItem(
                    serialNumber: i + 1,
                    teacherName: teachers[i].name,
                    designation: teachers[i].designation,
                    classes: teachers[i].classes,
                    onDeleteSubject: (cls, subject) =>
                        _confirmDelete(context, ref, cls, subject),
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditAssignSubClassScreen(teacher: teachers[i]),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

////