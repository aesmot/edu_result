/// একটা ক্লাসের ভেতরে একটা subject এবং তার assignment id।
class AssignedSubjectItem {
  final int assignmentId; // teacher_class_subjects.id
  final String subjectName;

  const AssignedSubjectItem({
    required this.assignmentId,
    required this.subjectName,
  });
}

/// একজন teacher এর একটা ক্লাস ও সেই ক্লাসের subject গুলো।
class ClassAssignment {
  final int classId;
  final String className;
  final List<AssignedSubjectItem> subjects;

  const ClassAssignment({
    required this.classId,
    required this.className,
    required this.subjects,
  });
}

/// একজন teacher ও তার সব assignment (ক্লাস অনুযায়ী)।
class TeacherWithAssignedClass {
  final String userId;
  final String name;
  final String? designation;
  final List<ClassAssignment> classes;

  const TeacherWithAssignedClass({
    required this.userId,
    required this.name,
    this.designation,
    required this.classes,
  });

  bool get hasAssignments => classes.isNotEmpty;
}