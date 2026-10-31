
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/examination.dart';
import '../../domain/repositories/examination_repository.dart';

/// Fetches examination data from Supabase.
class SupabaseExaminationRepository implements ExaminationRepository {
  final SupabaseClient _supabaseClient;

  SupabaseExaminationRepository(this._supabaseClient);

  @override
  Future<List<Examination>> getActiveExaminations() async {
    final response = await _supabaseClient
        .from('examinations')
        .select('id, name, academic_year')
        .eq('is_active', true)
        .order('academic_year', ascending: false)
        .order('name', ascending: true);

    return response
        .map<Examination>(
          (json) => Examination.fromJson(json),
    )
        .toList();
  }
}
