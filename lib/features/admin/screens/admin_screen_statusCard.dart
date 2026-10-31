import 'package:flutter/material.dart';
import '../../../core/constant/app_colors.dart';

class AdminDashboardStatusGrid extends StatefulWidget {
  const AdminDashboardStatusGrid({super.key});

  @override
  State<AdminDashboardStatusGrid> createState() =>
      _AdminDashboardStatusGridState();
}

class _AdminDashboardStatusGridState
    extends State<AdminDashboardStatusGrid> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> dashboardItems = [
  {
  'title': 'Total Students',
  'count': '1,250',
  'icon': Icons.people_rounded,
  'accentColor': const Color(0xFF2563EB),
  'bgColor': const Color(0xFFF8FAFC),
  'iconBg': const Color(0xFFDBEAFE),
  'trend': '+12% vs last term',
  'isPositive': true,
  },
  {
  'title': 'Subject',
  'count': '26',
  'icon': Icons.co_present_rounded,
  'accentColor': const Color(0xFF10B981), // Green
  'bgColor': const Color(0xFFF8FAFC),
  'iconBg': const Color(0xFFD1FAE5),
  'trend': '+5% vs last term',
  'isPositive': true,
  },
  {
  'title': 'Classes',
  'count': '10',
  'icon': Icons.school_rounded,
  'accentColor': const Color(0xFF8B5CF6), // Purple
  'bgColor': const Color(0xFFF8FAFC),
  'iconBg': const Color(0xFFEDE9FE),
  'trend': '+0% vs last term',
  'isPositive': true,
  },
  {
  'title': 'Examinations',
  'count': '03',
  'icon': Icons.assignment_rounded,
  'accentColor': const Color(0xFFF97316), // Orange
  'bgColor': const Color(0xFFF8FAFC),
  'iconBg': const Color(0xFFFFEDD5),
  'trend': '+1 vs last term',
  'isPositive': true,
  },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GridView.builder(
        itemCount: dashboardItems.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // প্রতি লাইনে ২টি করে কার্ড থাকবে
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.2,
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
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: item['bgColor'] as Color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isActive ? accentColor : AppColors.border,
                  width: isActive ? 1.5 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withValues(
                      alpha: isActive ? 0.12 : 0.04,
                    ),
                    blurRadius: isActive ? 10 : 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Row(
                  children: [
                    // বাম পাশের রঙিন স্ট্রিপ
                    Container(
                      width: 5,
                      color: accentColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: item['iconBg'] as Color,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                item['icon'] as IconData,
                                size: 24,
                                color: accentColor,
                              ),
                            ),
                            const SizedBox(width: 12),
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
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item['count'] as String,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.arrow_upward_rounded,
                                        size: 12,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 2),
                                      Expanded(
                                        child: Text(
                                          item['trend'] as String,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
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
  }
}