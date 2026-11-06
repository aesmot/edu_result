import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/examination_model.dart';


abstract class ExaminationRemoteDataSource {
  Future<List<ExaminationModel>> getActiveExaminations();
}

class SupabaseExaminationRemoteDataSource implements ExaminationRemoteDataSource {
  final SupabaseClient supabaseClient;

  SupabaseExaminationRemoteDataSource(this.supabaseClient);

  @override
  Future<List<ExaminationModel>> getActiveExaminations() async {
    try {
      final response = await supabaseClient
          .from('examinations') // আপনার ডাটাবেজের টেবিলের নাম
          .select()
          .eq('is_active', true) // শুধুমাত্র একটিভ এক্সামিনেশন ফিল্টার করার জন্য
          .order('created_at', ascending: false);

      // রেসপন্সকে মডেল লিস্টে রূপান্তর
      return (response as List)
          .map((json) => ExaminationModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch active examinations: $e');
    }
  }
}