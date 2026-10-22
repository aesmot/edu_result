import 'package:flutter/material.dart';
import '../../../core/constant/app_colors.dart';
//import '../../core/constant/app_colors.dart'; // Apnar AppColors file import kora hoyeche

class AdminDashboardStatsGrid extends StatefulWidget {
  const AdminDashboardStatsGrid({super.key});

  @override
  State<AdminDashboardStatsGrid> createState() => _AdminDashboardStatsGridState();
}

class _AdminDashboardStatsGridState extends State<AdminDashboardStatsGrid> {
  // Current selected card index track korar jonno variable (Default 0 mane prothom card active thakbe)
  int selectedIndex = 0;

  // Card-gulo data list akare rakha holo jate easily loop চালানো jay
  final List<Map<String, dynamic>> dashboardItems = [
    {
      'title': 'Teacher',
      'count': '45',

      'icon': Icons.people_rounded,
    },
    {
      'title': 'Subject & Class',
      'count': '24',
      'icon': Icons.menu_book_rounded,
    },
    {
      'title': 'Result',
      'count': '16',

      'icon': Icons.class_rounded,
    },
    {
      'title': 'পরীক্ষা',
      'count': '05',

      'icon': Icons.assignment_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: List.generate(dashboardItems.length, (index) {
          final item = dashboardItems[index];

          // Check kora hocche ei card-ti ekhon active kina
          final bool isActive = selectedIndex == index;

          return Expanded(
            child: Padding(
              // Pasapasi card-গুলোর মাঝে ছোট gap rakhar jonno
              padding: EdgeInsets.symmetric(horizontal: index == 0 ? 0 : 4.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index; // Tap korle oi card active hoye jabe
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    // Active thakle blue border ar normal thakle default border show korbe
                    border: Border.all(
                      color: isActive ? AppColors.primaryGradientStart : AppColors.border,
                      width: isActive ? 1.5 : 1.0,
                    ),
                    // Active card-er kache sundor blue glowing shadow ashbe
                    boxShadow: [
                      BoxShadow(
                        color: isActive
                            ? AppColors.primaryGradientStart.withOpacity(0.12)
                            : Colors.black.withOpacity(0.03),
                        blurRadius: isActive ? 10 : 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Gradient background wala choto Icon Container
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primaryGradientStart,
                              AppColors.primaryGradientEnd,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          item['icon'],
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Card Title (e.g., Shikkhok)
                      Text(
                        item['title'],
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),

                      // Count text (e.g., 48-ti)
                      Text(
                        item['count'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 6),



                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}