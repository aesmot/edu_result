import 'package:flutter/material.dart';
import 'package:result_management_system/features/admin/screens/widget/gradiant_action_btn.dart';
import '../../../core/constant/app_colors.dart';
//import '../../core/constant/app_colors.dart'; // Apnar AppColors file

class RecentActivitiesList extends StatefulWidget {
  const RecentActivitiesList({super.key});

  @override
  State<RecentActivitiesList> createState() => _RecentActivitiesListState();
}

class _RecentActivitiesListState extends State<RecentActivitiesList> {
  @override
  Widget build(BuildContext context) {
    // Demo Activity Data List
    final List<Map<String, dynamic>> activities = [
      {
        'avatarText': 'E',
        'avatarColor': const Color(0xFF6366F1), // Purple Gradient Tone

        'time': '৩৫ মিনিট আগে',
        'title': '২য় সাময়িকী পরীক্ষার সিট প্ল্যান ও হল শিডিউল প্রস্তুত',

        'isButton': true,
        'actionText': 'Approve',
        'actionIcon': Icons.check_circle_outline_rounded,
      },
      {

        'avatarColor': const Color(0xFF0EA5E9), // Blue Tone

        'time': '১ ঘণ্টা আগে',
        'title': '১০ম শ্রেণির পদ্মা সেকশন রুম ৩০১ এ স্থানান্তরের অনুরোধ',
        'subtitle': 'ধারণক্ষমতা ৪৮ জন · মাল্টিমিডিয়া প্রজেক্টর সংযুক্ত',
        'isButton': false,
        'actionText': 'Done',
        'actionIcon': Icons.check,
      },
    ];

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
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: activities.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          thickness: 1,
          color: AppColors.border,
        ),
        itemBuilder: (context, index) {
          final item = activities[index];
          return _buildActivityItem(item);
        },
      ),
    );
  }

  // Single Activity Item Layout
  Widget _buildActivityItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(width: 8),

          // 2. Middle Details Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 6),

                // Main Title
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),

                // Subtitle details
                // Category Tag & Time Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF), // Light Blue Background
                        borderRadius: BorderRadius.circular(6),
                      ),

                    ),
                    //const SizedBox(width: 6),
                    const Text('·', style: TextStyle(color: AppColors.textMuted)),
                    const SizedBox(width: 6),
                    Text(
                      item['time'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // 3. Right Action Area (Gradient Button or Status Badge)
          item['isButton']
              ? GradientActionButton(
            text: item['actionText'], // ডায়নামিক টেক্সট (যেমন: Approve)
            icon: item['actionIcon'], // ডায়নামিক আইকন
            onPressed: () {
              // বাটনে ক্লিক করার লজিক
            },
          )
              : _buildStatusBadge(
            item['actionText'], // ডায়নামিক টেক্সট (যেমন: Done)
            item['actionIcon'], // ডায়নামিক আইকন
          ),
        ],
      ),
    );
  }

/*
  // Active Blue Gradient Action Button Widget
  Widget _buildGradientButton(String text, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primaryGradientStart,
            AppColors.primaryGradientEnd,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 16),
                const SizedBox(width: 6),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }*/
  Widget _buildStatusBadge(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5), // Light Green Background
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
              color: const Color(0xFF059669),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}