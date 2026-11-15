/// একজন teacher কে একটা ক্লাসের একটা subject assign করার তথ্য।
/// Supabase এর teacher_class_subjects row থেকে বানানো হয়।
class AssignSubjectTeacher {
  final int id; // teacher_class_subjects.id
  final int teacherClassId; // teacher_classes.id
  final int classSubjectId; // class_subjects.class_subject_id
  final String teacherUserId;
  final String teacherName;
  final String? teacherEmail;
  final int classId;
  final String className;
  final String subjectName;

  const AssignSubjectTeacher({
    required this.id,
    required this.teacherClassId,
    required this.classSubjectId,
    required this.teacherUserId,
    required this.teacherName,
    this.teacherEmail,
    required this.classId,
    required this.className,
    required this.subjectName,
  });
}