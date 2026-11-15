import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/class_result_model.dart'; // আপনার প্রজেক্টের পাথ অনুযায়ী ইমপোর্ট ঠিক করে নেবেন

class ClassResultRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // টেবিলের নাম আপনার ডাটাবেজ অনুযায়ী পরিবর্তন করে নিতে পারেন (যেমন: 'classes', 'class_results' ইত্যাদি)
  final String _tableName = 'class_results';

  /// Supabase থেকে সব ক্লাসের রেজাল্ট সামারি ফেচ করার ফাংশন
  Future<List<ClassResultModel>> fetchClassResults() async {
    try {
      final response = await _supabase
          .from(_tableName)
          .select()
          .order('class_name', ascending: true); // ক্লাসের নাম অনুযায়ী সাজাতে পারেন

      // রেসপন্সকে লিস্ট অব মডেল-এ রূপান্তর করা
      final List<ClassResultModel> results = (response as List)
          .map((data) => ClassResultModel.fromMap(data))
          .toList();

      return results;
    } catch (e) {
      throw 'Failed to load class results: ${e.toString()}';
    }
  }

  // যদি নির্দিষ্ট কোনো ক্লাসের রেজাল্ট আনতে চান
  Future<ClassResultModel> fetchClassResultById(String id) async {
    try {
      final response = await _supabase
          .from(_tableName)
          .select()
          .eq('id', id)
          .single();

      return ClassResultModel.fromMap(response);
    } catch (e) {
      throw 'Failed to load class result: ${e.toString()}';
    }
  }
}