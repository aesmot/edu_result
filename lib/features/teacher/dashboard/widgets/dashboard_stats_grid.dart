
import 'package:flutter/material.dart';

import 'dashboard_stat_card.dart';

class DashboardStatsGrid extends StatelessWidget {
  const DashboardStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.25,
      children: const [
        DashboardStatCard(
          title: 'Classes',
          value: '4',
          icon: Icons.class_,
          color: Color(0xFF4C9EEB),
        ),
        DashboardStatCard(
          title: 'Subjects',
          value: '6',
          icon: Icons.menu_book,
          color: Color(0xFF14B8A6),
        ),

        DashboardStatCard(
          title: 'Results',
          value: '2',
          icon: Icons.pending_actions,
          color: Color(0xFF8B5CF6),
        ),
      ],
    );
  }
}
