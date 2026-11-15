import 'subject.dart';

/// একটা ক্লাস ও তার subject গুলো।
class ClassSubjects {
  final int classId;
  final String className;
  final List<Subject> subjects;

  const ClassSubjects({
    required this.classId,
    required this.className,
    required this.subjects,
  });
}