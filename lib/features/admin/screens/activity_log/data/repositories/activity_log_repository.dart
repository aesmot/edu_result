import '../../domain/entities/activity_log.dart';
//import '../entities/activity_log.dart';

/// Admin dashboard-er activity log-er jonno ki ki operation lagbe.
abstract interface class ActivityLogRepository {
  /// Shorboshesh activity gulo ekbar niye ashe (pull-to-refresh-er jonno).
  Future<List<ActivityLog>> getRecentActivities({int limit = 20});

  /// Notun activity hole shathe shathe update dey (Realtime).
  Stream<List<ActivityLog>> watchRecentActivities({int limit = 20});

  /// Admin ek click kore activity approve korbe.
  Future<void> approveActivity(String id);
}