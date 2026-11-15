import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:result_management_system/features/admin/screens/widget/result_state_card/Admin_result_view_card.dart';
import '../../../core/constant/app_colors.dart';
import '../../result_view/presentation/screens/admin_result_screen.dart';
import '../../subject/screens/admin_classwise_subject_list.dart';
import '../presentation/providers/admin_dashboard_statecard_provider.dart';

// আপনার classwise_subject_list পেজটি যে ফোল্ডারে আছে, সেই সঠিক পাথ এখানে ইম্পোর্ট করুন:
// import '../screens/admin_classwise_subject_list.dart'; // উদাহরণ স্বরূপ

class AdminDashboardStatusCard extends ConsumerStatefulWidget {
  const AdminDashboardStatusCard({super.key});

  @override
  ConsumerState<AdminDashboardStatusCard> createState() =>
      _AdminDashboardStatusGridState();
}

class _AdminDashboardStatusGridState
    extends ConsumerState<AdminDashboardStatusCard> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final statsAsync = ref.watch(admin_dashboard_statecard_provider);

    return statsAsync.when(
      loading: () => const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => SizedBox(
        height: 80,
        child: Center(child: Text('ডাটা লোড করতে সমস্যা হয়েছে: $err')),
      ),
      data: (stats) {
        final dashboardItems = [
          {
            'title': 'Total Students',
            'count': stats.totalStudents.toString(),
            'icon': Icons.people_rounded,
            'accentColor': const Color(0xFF2563EB),
            'bgColor': const Color(0xFFF8FAFC),
          },
          {
            'title': 'Subject',
            'count': stats.totalSubjects.toString(),
            'icon': Icons.co_present_rounded,
            'accentColor': const Color(0xFF10B981),
            'bgColor': const Color(0xFFF8FAFC),
          },
          {
            'title': 'View Result',
            'count': stats.totalResults.toString(),
            'icon': Icons.school_rounded,
            'accentColor': const Color(0xFF8B5CF6),
            'bgColor': const Color(0xFFF8FAFC),
          },
          {
            'title': 'Examinations',
            'count': stats.totalExaminations.toString(),
            'icon': Icons.assignment_rounded,
            'accentColor': const Color(0xFFF97316),
            'bgColor': const Color(0xFFF8FAFC),
          },
        ];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: GridView.builder(
            itemCount: dashboardItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.6,
            ),
            itemBuilder: (context, index) {
              final item = dashboardItems[index];
              final bool isActive = selectedIndex == index;
              final Color accentColor = item['accentColor'] as Color;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });

                  // 'Subject' কার্ডে ক্লিক করলে classwise_subject_list পেজে যাবে
                  if (item['title'] == 'Subject') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminClasswiseSubjectList(), // আপনার পেজের ক্লাস নেম এখানে বসাবেন
                      ),
                    );
                  }
                  // 'View Result' এ ক্লিক করলে AdminResultScreen পেজে যাবে
                  else if (item['title'] == 'View Result') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminResultScreen(),
                      ),
                    );
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: item['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isActive ? accentColor : AppColors.border,
                      width: isActive ? 1.5 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withValues(
                          alpha: isActive ? 0.12 : 0.04,
                        ),
                        blurRadius: isActive ? 8 : 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          color: accentColor,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    item['icon'] as IconData,
                                    size: 20,
                                    color: accentColor,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item['title'] as String,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 1),
                                      Text(
                                        item['count'] as String,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}