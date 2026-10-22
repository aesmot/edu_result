import 'package:flutter/material.dart';

import '../../core/constant/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      backgroundColor: AppColors.navBackground,
      selectedItemColor: AppColors.primaryGradientStart,
      unselectedItemColor: AppColors.navUnselected,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Result',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Admin',
        ),

      ],
    );
  }
}