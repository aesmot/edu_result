import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:result_management_system/shared/widgets/app_bar.dart';

import '../domain/models/class_subjects.dart';
import '../domain/models/subject.dart';
import '../providers/admin_subject_provider.dart';
import '../widgets/class_card.dart';


class AdminClasswiseSubjectList extends ConsumerStatefulWidget {
  const AdminClasswiseSubjectList({super.key});

  @override
  ConsumerState<AdminClasswiseSubjectList> createState() =>
      _AdminClasswiseSubjectListState();
}

class _AdminClasswiseSubjectListState
    extends ConsumerState<AdminClasswiseSubjectList> {
  // আগে: String? _selectedSubjectId;
  String? _selectedKey; // "classId_subjectId"

  void _showMessage(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  String _cleanError(Object e) => e.toString().replaceFirst('Exception: ', '');

  Future<void> _confirmDelete(ClassSubjects group, Subject subject) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('সাবজেক্ট মুছবেন?'),
        content: Text('"${subject.name}" কে ${group.className} থেকে সরানো হবে।'),
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
      await ref.read(adminSubjectRepositoryProvider).removeSubjectFromClass(
        group.classId,
        int.parse(subject.id),
      );
      ref.invalidate(adminClassSubjectsProvider);
      if (mounted) setState(() => _selectedKey  = null);
      _showMessage('"${subject.name}" সরানো হয়েছে');
    } catch (e) {
      _showMessage(_cleanError(e));
    }
  }

  Future<void> _showAddSubjectDialog(ClassSubjects group) async {
    try {
      final allSubjects = await ref.read(adminAllSubjectsProvider.future);
      final existingIds = group.subjects.map((s) => s.id).toSet();
      final available =
      allSubjects.where((s) => !existingIds.contains(s.id)).toList();

      if (!mounted) return;

      if (available.isEmpty) {
        _showMessage('যোগ করার মতো আর কোনো সাবজেক্ট নেই');
        return;
      }

      final selected = await showDialog<Subject>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('${group.className} এ সাবজেক্ট যোগ করুন'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: available.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(available[i].name),
                trailing: const Icon(Icons.add_rounded),
                onTap: () => Navigator.pop(ctx, available[i]),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('বাতিল'),
            ),
          ],
        ),
      );

      if (selected == null) return;

      await ref.read(adminSubjectRepositoryProvider).addSubjectToClass(
        group.classId,
        int.parse(selected.id),
      );
      ref.invalidate(adminClassSubjectsProvider);
      _showMessage('"${selected.name}" যোগ হয়েছে');
    } catch (e) {
      _showMessage(_cleanError(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final classSubjectsAsync = ref.watch(adminClassSubjectsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: UserAppBar(),
      body: classSubjectsAsync.when(
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
                  onPressed: () => ref.invalidate(adminClassSubjectsProvider),
                  child: const Text('আবার চেষ্টা করুন'),
                ),
              ],
            ),
          ),
        ),
        data: (groups) {
          if (groups.isEmpty) {
            return const Center(
              child: Text(
                'কোনো ক্লাস পাওয়া যায়নি!',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(adminClassSubjectsProvider.future),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.all(12),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];
                return
                ClassCard(
                  className: group.className,
                  subjects: group.subjects,
                  selectedSubjectId: _selectedKey?.startsWith('${group.classId}_') == true
                      ? _selectedKey!.substring('${group.classId}_'.length)
                      : null,
                  onSelect: (id) => setState(() {
                    _selectedKey = id == null ? null : '${group.classId}_$id';
                  }),
                  onDelete: (subject) => _confirmDelete(group, subject),
                  onAdd: () => _showAddSubjectDialog(group),
                );
              },
            ),
          );
        },
      ),
    );
  }
}





