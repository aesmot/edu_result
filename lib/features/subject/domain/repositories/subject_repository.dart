import '../models/subject.dart';

/// Defines the contract for retrieving class-wise subject data.
abstract class SubjectRepository {
  /// Fetches subjects assigned to a specific class.
  Future<List<Subject>> getSubjectsByClass(int classId);

  /// Fetches all classes with their assigned subjects (admin use).
  /// Key = class name, value = subjects for that class.
  Future<Map<String, List<Subject>>> getAllClassSubjects();
}