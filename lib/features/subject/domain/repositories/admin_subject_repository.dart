import '../models/class_subjects.dart';
import '../models/subject.dart';

/// Admin এর জন্য subject সংক্রান্ত contract।
abstract class AdminSubjectRepository {
  /// সব ক্লাস ও তাদের subject (ক্লাস অনুযায়ী)।
  Future<List<ClassSubjects>> getAllClassSubjects();

  /// Add dialog এ দেখানোর জন্য সব subject।
  Future<List<Subject>> getAllSubjects();

  /// ক্লাসে একটা subject যোগ করে।
  Future<void> addSubjectToClass(int classId, int subjectId);

  /// ক্লাস থেকে subject সরায়। Marks থাকলে মোছা যাবে না।
  Future<void> removeSubjectFromClass(int classId, int subjectId);
}