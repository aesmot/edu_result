import 'package:flutter/material.dart';

import '../../core/constant/app_colors.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UserAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      backgroundColor: Colors.blue, // AppBar background color blue
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      // ----------------- [ পরিবর্তন ১: Gradient যুক্ত করা ] -----------------
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryGradientStart,
              AppColors.primaryGradientEnd,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      // ------------------------------------------------------------------

      title: Row(
        children: [
          // Demo Avatar
          const CircleAvatar(
            radius: 23,
            backgroundColor: Colors.white, // Avatar circle color
            child: Icon(
              Icons.person,
              size: 30,
              color: Colors.blue, // Avatar icon color
            ),
          ),

          const SizedBox(width: 12),

          // Demo Name and Designation
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Esmot Ara',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // User name text color
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Administrator',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70, // Designation text color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      actions: [
        // Notification Button (IconButton a convert kora holo)
        IconButton(
          onPressed: () {
            // Notification action
          },
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.white,
            size: 25,
          ),
        ),

        // --- [ Notun Logout Button add kora holo ] ---
        IconButton(
          onPressed: () async {
            try {
              await Supabase.instance.client.auth.signOut();

              if (!context.mounted) return;

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
                    (route) => false,
              );
            } catch (e) {
              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logout failed: $e'),
                ),
              );
            }
          },
          icon: const Icon(
            Icons.logout_rounded,
            color: Colors.white,
            size: 25,
          ),
          tooltip: 'Logout',
        ),

        const SizedBox(width: 10),
      ],

      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(
          height: 1,
          thickness: 1,
          color: Colors.white24, // Bottom divider line color
        ),
      ),
    );
  }
}