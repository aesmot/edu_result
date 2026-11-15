import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../dashboard/data/repositories/admin_dashboard_repository.dart';
import '../../domain/models/admin_dashboard_stats_model.dart';

// ১. রিপোজিটরি প্রোভাইডার
final adminDashboardRepositoryProvider = Provider<AdminDashboardRepository>((ref) {
  return AdminDashboardRepository(Supabase.instance.client);
});

// ২. আপনার দেওয়া নামানুসারে ড্যাশবোর্ড স্টেট কার্ডের ফিউচার প্রোভাইডার
final admin_dashboard_statecard_provider = FutureProvider<AdminDashboardStatsModel>((ref) async {
  final repository = ref.watch(adminDashboardRepositoryProvider);
  return repository.fetchDashboardStats();
});