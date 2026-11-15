
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasources/teacher_profile_remote_data_source.dart';
import '../../data/repositories/teacher_profile_repository_impl.dart';
import '../../domain/repositories/teacher_profile_repository.dart';

/// Provides Supabase client.
final teacherProfileSupabaseProvider =
Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// Provides teacher profile remote data source.
final teacherProfileRemoteDataSourceProvider =
Provider<TeacherProfileRemoteDataSource>((ref) {
  final supabase = ref.watch(teacherProfileSupabaseProvider);

  return TeacherProfileRemoteDataSource(supabase);
});

/// Provides teacher profile repository.
final teacherProfileRepositoryProvider =
Provider<TeacherProfileRepository>((ref) {
  final dataSource =
  ref.watch(teacherProfileRemoteDataSourceProvider);

  return TeacherProfileRepositoryImpl(dataSource);
});
