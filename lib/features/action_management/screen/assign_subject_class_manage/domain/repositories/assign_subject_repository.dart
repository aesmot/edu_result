import '../models/assign_subject_teacher.dart';
import '../models/teacher_info.dart';

/// Teacher কে subject assign সংক্রান্ত contract।
abstract class AssignSubjectRepository {
  /// সব teacher এর assign করা subject (ক্লাস ও teacher এর নাম সহ)।
  Future<List<AssignSubjectTeacher>> getAllAssignments();

  /// একটা assignment মোছে (teacher_class_subjects এর row)।
  Future<void> deleteAssignment(int assignmentId);


  /// সব teacher এর তালিকা (teacher_profiles থেকে)।
  Future<List<TeacherInfo>> getTeachers();

  /// teacher কে ক্লাসের একটা subject assign করে।
  Future<void> assignSubject({
    required String teacherUserId,
    required int classId,
    required int subjectId,
  });

  /// teacher এর একটা ক্লাস এবং সেই ক্লাসের সব subject মোছে।
  Future<void> deleteClassAssignment({
    required String teacherUserId,
    required int classId,
  });
}