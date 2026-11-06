import '../../domain/entities/activity_log.dart';
import '../../domain/repositories/activity_log_repository.dart';
import '../datasources/activity_log_remote_data_source.dart';
import 'activity_log_repository.dart';
// import 'activity_log_repository.dart'; // ডুপ্লিকেট ইম্পোর্ট দরকার নেই, বাদ দিতে পারেন

/// ActivityLogRepository-er asol kaj, data source use kore.
class ActivityLogRepositoryImpl implements ActivityLogRepository {
  ActivityLogRepositoryImpl(this._dataSource);

  final ActivityLogRemoteDataSource _dataSource;

  @override
  Future<List<ActivityLog>> getRecentActivities({int limit = 20}) {
    return _dataSource.getRecentActivities(limit: limit);
  }

  @override
  Stream<List<ActivityLog>> watchRecentActivities({int limit = 20}) {
    return _dataSource.watchRecentActivities(limit: limit);
  }

  @override
  Future<void> approveActivity(String id) {
    return _dataSource.approveActivity(id);
  }
}