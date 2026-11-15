import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/repositories/supabase_admin_subject_repository.dart';

import '../domain/models/class_subjects.dart';
import '../domain/models/subject.dart';
import '../domain/repositories/admin_subject_repository.dart';

/// Admin এর repository। শুধু এই ফাইলের provider গুলো ব্যবহার করবে।
final adminSubjectRepositoryProvider = Provider<AdminSubjectRepository>((ref) {
  return SupabaseAdminSubjectRepository(Supabase.instance.client);
});

/// Admin: সব ক্লাস ও তাদের subject (ক্লাস অনুযায়ী)।
final adminClassSubjectsProvider =
FutureProvider<List<ClassSubjects>>((ref) async {
  return ref.watch(adminSubjectRepositoryProvider).getAllClassSubjects();
});

/// Admin: Add dialog এ দেখানোর জন্য সব subject।
final adminAllSubjectsProvider = FutureProvider<List<Subject>>((ref) async {
  return ref.watch(adminSubjectRepositoryProvider).getAllSubjects();
});