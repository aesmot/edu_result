import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../domain/models/admin_dashboard_stats_model.dart';


class AdminDashboardRepository {
  final SupabaseClient _supabaseClient;

  AdminDashboardRepository(this._supabaseClient);

  Future<AdminDashboardStatsModel> fetchDashboardStats() async {
    try {
      // নির্দিষ্ট কলাম 'id' না লিখে '*' সিলেক্ট করা হচ্ছে যাতে যেকোনো কলামের নামের সাথেই কাজ করে
      final studentsData = await _supabaseClient.from('students').select('*');
      final subjectsData = await _supabaseClient.from('subjects').select('*');
      final resultsData = await _supabaseClient.from('marks').select('*');
      final examsData = await _supabaseClient.from('examinations').select('*');

      return AdminDashboardStatsModel(
        totalStudents: (studentsData as List).length,
        totalSubjects: (subjectsData as List).length,
        totalResults: (resultsData as List).length,
        totalExaminations: (examsData as List).length,
      );
    } catch (e) {
      print('=== SUPABASE DASHBOARD ERROR: $e ===');
      throw Exception('ড্যাশবোর্ড ডাটা আনতে সমস্যা হয়েছে: $e');
    }
  }
}