
import '../models/subject.dart';

/// Defines the contract for retrieving subject data.
abstract class SubjectRepository {
  /// Fetches subjects from the data source.
  Future<List<Subject>> getSubjects();
}
