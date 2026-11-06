import '../models/student_mark.dart';

abstract class MarkEntryRepository {
  Future<void> saveStudentMarks(List<StudentMark> marksList);
  Future<List<StudentMark>> getMarksBySubjectAndExam({
    required int classSubjectId,
    required String examinationId,
  });
}