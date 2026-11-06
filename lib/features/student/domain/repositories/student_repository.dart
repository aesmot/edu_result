import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/student_model.dart';

class StudentRepository {
  final SupabaseClient _supabase;

  StudentRepository(this._supabase);

  /// নির্দিষ্ট class_id অনুযায়ী অ্যাক্টিভ শিক্ষার্থীদের রোল ক্রমানুসারে নিয়ে আসা
  Future<List<StudentModel>> getStudentsByClassId(int classId) async {
    try {
      final response = await _supabase
          .from('students')
          .select('student_id, roll_number, student_name, class_id, is_active')
          .eq('class_id', classId)
          .eq('is_active', true)
          .order('roll_number', ascending: true);

      return (response as List)
          .map((json) => StudentModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('স্টুডেন্ট লিস্ট লোড করতে সমস্যা হয়েছে: $e');
    }


  }
}