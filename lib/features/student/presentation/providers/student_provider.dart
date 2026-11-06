import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/student_model.dart';
import '../../data/repositories/student_repository_impl.dart';
import '../../domain/repositories/student_repository.dart';

// Supabase Repository Provider
final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  return StudentRepository(Supabase.instance.client);
});

// Class ID পাঠালে উক্ত ক্লাসের স্টুডেন্টদের ফেচ করে নিয়ে আসার প্রোভাইডার
final studentsByClassProvider =
FutureProvider.family<List<StudentModel>, int>((ref, classId) async {
  final repository = ref.watch(studentRepositoryProvider);
  return repository.getStudentsByClassId(classId);
});