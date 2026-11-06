import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasources/activity_log_remote_data_source.dart';
import '../../data/repositories/activity_log_repository.dart';
import '../../data/repositories/activity_log_repository_impl.dart';
import '../../domain/entities/activity_log.dart';
import '../../domain/repositories/activity_log_repository.dart';

/// Repository toiri kore (auth_providers.dart-er moto).
final activityLogRepositoryProvider = Provider<ActivityLogRepository>((ref) {
  final client = Supabase.instance.client;
  final dataSource = ActivityLogRemoteDataSource(client);

  return ActivityLogRepositoryImpl(dataSource);
});

/// Realtime: notun activity hole dashboard nije theke update hobe.
final recentActivitiesProvider =
StreamProvider.autoDispose<List<ActivityLog>>((ref) {
  final repository = ref.watch(activityLogRepositoryProvider);

  return repository.watchRecentActivities(limit: 20);
});