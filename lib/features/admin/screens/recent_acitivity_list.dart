import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:result_management_system/features/admin/screens/widget/gradiant_action_btn.dart';
import '../../../core/constant/app_colors.dart';
//import '../providers/activity_log_providers.dart';
import 'activity_log/presentation/providers/activity_log_providers.dart'; // আপনার প্রোভাইডার পাথ

class RecentActivitiesList extends ConsumerWidget {
  const RecentActivitiesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ১. সুপাবেস থেকে রিভারপডের মাধ্যমে রিয়েলটাইম ডাটা ওয়াচ করা
    //final activitiesStream = ref.watch(activityLogRepositoryProvider);
    final activitiesStream = ref.watch(recentActivitiesProvider);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: activitiesStream.when(
        data: (activities) {
          // সর্বোচ্চ ৫টি আইটেম লিমিট করা
          final limitedActivities = activities.take(5).toList();

          if (limitedActivities.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(
                child: Text('কোনো সাম্প্রতিক অ্যাক্টিভিটি নেই', style: TextStyle(color: AppColors.textMuted)),
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: limitedActivities.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              thickness: 1,
              color: AppColors.border,
            ),
            itemBuilder: (context, index) {
              final activity = limitedActivities[index];

              // সুপাবেস স্ট্যাটাস চেক (অ্যাপ্রুভড কি না)
              final bool isPending = activity.status != 'approved';

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Text(
                            activity.actionType.name.toUpperCase(), // অথবা activity.description
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                activity.description,
                                style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                              ),
                              const SizedBox(width: 6),
                              const Text('·', style: TextStyle(color: AppColors.textMuted)),
                              const SizedBox(width: 6),
                              Text(
                                '${activity.createdAt.hour}:${activity.createdAt.minute.toString().padLeft(2, '0')}',
                                style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // ১ ক্লিকে সুপাবেসে স্ট্যাটাস আপডেট করার লজিক
                    isPending
                        ? GradientActionButton(
                      text: 'Approve',
                      icon: Icons.check_circle_outline_rounded,
                      onPressed: () async {
                        await Supabase.instance.client
                            .from('activity_logs')
                            .update({'status': 'approved'})
                            .eq('id', activity.id);
                      },
                    )
                        : _buildStatusBadge('Done', Icons.check),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Padding(
          padding: EdgeInsets.all(30.0),
          child: Center(child: CircularProgressIndicator(color: Colors.teal)),
        ),
        error: (error, stack) => Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(child: Text('Error: $error', style: const TextStyle(color: Colors.red, fontSize: 12))),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFFA7F3D0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF059669), size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF059669),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}