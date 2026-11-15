import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/assign_subject_teacher.dart';
import '../domain/models/teacher_with_assigned_class.dart';
import 'assign_subject_provider.dart';

/// সব teacher, প্রত্যেকের ক্লাস অনুযায়ী গুছানো assignment সহ।
/// যার কিছু assign হয়নি, তার classes খালি থাকবে।
final teacherWithAssignmentsProvider =
FutureProvider<List<TeacherWithAssignedClass>>((ref) async {
  final repository = ref.watch(assignSubjectRepositoryProvider);

  final teachers = await repository.getTeachers();
  final assignments = await repository.getAllAssignments();

  // teacherUserId -> তার assignment গুলো
  final byTeacher = <String, List<AssignSubjectTeacher>>{};
  for (final a in assignments) {
    byTeacher.putIfAbsent(a.teacherUserId, () => []).add(a);
  }

  final result = <TeacherWithAssignedClass>[];

  for (final teacher in teachers) {
    final teacherAssignments = byTeacher[teacher.userId] ?? const [];

    // classId -> ওই ক্লাসের subject গুলো
    final byClass = <int, List<AssignSubjectTeacher>>{};
    for (final a in teacherAssignments) {
      byClass.putIfAbsent(a.classId, () => []).add(a);
    }

    final classIds = byClass.keys.toList()..sort();

    final classes = <ClassAssignment>[
      for (final classId in classIds)
        ClassAssignment(
          classId: classId,
          className: byClass[classId]!.first.className,
          subjects: [
            for (final a in byClass[classId]!)
              AssignedSubjectItem(
                assignmentId: a.id,
                subjectName: a.subjectName,
              ),
          ]..sort((x, y) => x.subjectName.compareTo(y.subjectName)),
        ),
    ];

    final name = teacher.name?.trim();
    result.add(
      TeacherWithAssignedClass(
        userId: teacher.userId,
        name: (name != null && name.isNotEmpty) ? name : 'Unknown',
        designation: teacher.designation,
        classes: classes,
      ),
    );
  }

  return result;
});