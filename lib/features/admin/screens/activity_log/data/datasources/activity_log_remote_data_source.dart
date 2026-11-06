import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/activity_log_model.dart';

/// Supabase theke `activity_logs` table-er data ane.
class ActivityLogRemoteDataSource {
  ActivityLogRemoteDataSource(this._supabase);

  final SupabaseClient _supabase;

  static const String _table = 'activity_logs';

  /// Shorboshesh activity gulo ekbar niye ashe.
  Future<List<ActivityLogModel>> getRecentActivities({
    int limit = 20,
  }) async {
    final data = await _supabase
        .from(_table)
        .select()
        .order('created_at', ascending: false)
        .limit(limit);

    return data.map<ActivityLogModel>(ActivityLogModel.fromJson).toList();
  }

  /// Notun activity hole shathe shathe notun list pathay (Realtime).
  Stream<List<ActivityLogModel>> watchRecentActivities({
    int limit = 10,
  }) {
    return _supabase
        .from(_table)
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .limit(limit)
        .map(
          (rows) =>
          rows.map<ActivityLogModel>(ActivityLogModel.fromJson).toList(),
    );
  }

  /// Admin ek click kore activity approve korbe.
  Future<void> approveActivity(String id) async {
    await _supabase
        .from(_table)
        .update({'status': 'approved'})
        .eq('id', id);
  }
}