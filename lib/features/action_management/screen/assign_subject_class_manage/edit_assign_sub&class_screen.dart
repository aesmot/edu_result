import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:result_management_system/shared/widgets/app_bar.dart';

import '../../../subject/domain/models/class_subjects.dart';
import '../../../subject/domain/models/subject.dart';
import '../../../subject/providers/admin_subject_provider.dart';
import 'domain/models/teacher_with_assigned_class.dart';



class EditAssignSubClassScreen extends ConsumerStatefulWidget {
  final TeacherWithAssignedClass teacher;

  const EditAssignSubClassScreen({super.key, required this.teacher});

  @override
  ConsumerState<EditAssignSubClassScreen> createState() =>
      _EditAssignSubClassScreenState();
}

class _EditAssignSubClassScreenState
    extends ConsumerState<EditAssignSubClassScreen> {
  int? _selectedClassId;
  String? _selectedSubjectId;

  @override
  Widget build(BuildContext context) {
    final teacher = widget.teacher;
    final classesAsync = ref.watch(adminClassSubjectsProvider);
    final hasDesignation = teacher.designation != null &&
        teacher.designation!.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: UserAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Selected Teacher',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                teacher.name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              if (hasDesignation) ...[
                                const SizedBox(height: 3),
                                Text(
                                  teacher.designation!.trim(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Icon(Icons.lock_outline,
                            size: 18, color: Colors.grey.shade500),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  classesAsync.when(
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (e, _) => Column(
                      children: [
                        Text('ত্রুটি: $e',
                            style: const TextStyle(color: Colors.red)),
                        const SizedBox(height: 8),
                        FilledButton(
                          onPressed: () =>
                              ref.invalidate(adminClassSubjectsProvider),
                          child: const Text('আবার চেষ্টা করুন'),
                        ),
                      ],
                    ),
                    data: (groups) => _buildSelectors(groups),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: _onAssign,
                          child: const Text('Assign'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectors(List<ClassSubjects> groups) {
    // নির্বাচিত ক্লাস
    ClassSubjects? selectedGroup;
    for (final g in groups) {
      if (g.classId == _selectedClassId) selectedGroup = g;
    }

    // এই teacher কে ওই ক্লাসে আগেই দেওয়া subject গুলো বাদ
    final assignedNames = <String>{};
    for (final c in widget.teacher.classes) {
      if (c.classId == _selectedClassId) {
        assignedNames.addAll(c.subjects.map((s) => s.subjectName));
      }
    }
    final availableSubjects = selectedGroup == null
        ? <Subject>[]
        : selectedGroup.subjects
        .where((s) => !assignedNames.contains(s.name))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Class',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        DropdownButtonFormField<int>(
          value: _selectedClassId,
          hint: const Text('ক্লাস বাছুন'),
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: [
            for (final g in groups)
              DropdownMenuItem(value: g.classId, child: Text(g.className)),
          ],
          onChanged: (v) => setState(() {
            _selectedClassId = v;
            _selectedSubjectId = null;
          }),
        ),
        const SizedBox(height: 16),
        const Text('Subject',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: _selectedSubjectId,
          hint: Text(_selectedClassId == null
              ? 'আগে ক্লাস বাছুন'
              : availableSubjects.isEmpty
              ? 'যোগ করার মতো subject নেই'
              : 'Subject বাছুন'),
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: [
            for (final s in availableSubjects)
              DropdownMenuItem(value: s.id, child: Text(s.name)),
          ],
          onChanged: availableSubjects.isEmpty
              ? null
              : (v) => setState(() => _selectedSubjectId = v),
        ),
      ],
    );
  }

  void _onAssign() {
    if (_selectedClassId == null || _selectedSubjectId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ক্লাস ও subject দুটোই বাছুন')),
      );
      return;
    }
    // TODO: পরের ধাপে Supabase insert
  }
}