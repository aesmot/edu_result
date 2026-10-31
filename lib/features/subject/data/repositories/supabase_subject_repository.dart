
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/subject.dart';
import '../../domain/repositories/subject_repository.dart';

/// Retrieves subject data from Supabase.
class SupabaseSubjectRepository implements SubjectRepository {
  final SupabaseClient _supabaseClient;

  SupabaseSubjectRepository(this._supabaseClient);

  @override
  Future<List<Subject>> getSubjects() async {
    final response = await _supabaseClient
        .from('subjects')
        .select('id, name, code, class_id')
        .order('name', ascending: true);

    return response
        .map<Subject>(
          (json) => Subject.fromJson(json),
    )
        .toList();
  }
}
