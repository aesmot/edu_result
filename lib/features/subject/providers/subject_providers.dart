
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/repositories/supabase_subject_repository.dart';
import '../domain/models/subject.dart';
import '../domain/repositories/subject_repository.dart';

/// Provides the repository responsible for fetching subjects from Supabase.
final subjectRepositoryProvider = Provider<SubjectRepository>((ref) {
  return SupabaseSubjectRepository(
    Supabase.instance.client,
  );
});

/// Fetches subjects and exposes loading, data, and error states.
final subjectsProvider = FutureProvider<List<Subject>>((ref) async {
  final repository = ref.watch(subjectRepositoryProvider);
  return repository.getSubjects();
});
