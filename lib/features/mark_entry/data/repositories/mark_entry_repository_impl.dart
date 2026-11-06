import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/models/student_mark.dart';
import '../../domain/repositories/mark_entry_repository.dart';

class MarkEntryRepositoryImpl implements MarkEntryRepository {
  final SupabaseClient _supabase;

  MarkEntryRepositoryImpl(this._supabase);

  @override
  Future<void> saveStudentMarks(List<StudentMark> marksList) async {
    try {
      final dataToInsert = marksList.map((e) => e.toJson()).toList();

      // Upsert: student_id, class_subject_id, examination_id মিলে গেলে আপডেট হবে
      await _supabase.from('marks').upsert(
        dataToInsert,
        onConflict: 'student_id, class_subject_id, examination_id',
      );
    } catch (e) {
      throw Exception('নম্বর সেভ করতে সমস্যা হয়েছে: $e');
    }
  }

  @override
  Future<List<StudentMark>> getMarksBySubjectAndExam({
    required int classSubjectId,
    required String examinationId,
  }) async {
    try {
      final response = await _supabase
          .from('marks')
          .select()
          .eq('class_subject_id', classSubjectId)
          .eq('examination_id', examinationId);

      return (response as List)
          .map((json) => StudentMark.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('মার্কস ফেচ করতে সমস্যা হয়েছে: $e');
    }
  }
}