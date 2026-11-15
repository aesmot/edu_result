import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/constant/app_colors.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/teacher/dashboard/controller/teacher_profile_controller.dart';

class UserAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const UserAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  ConsumerState<UserAppBar> createState() => _UserAppBarState();
}

class _UserAppBarState extends ConsumerState<UserAppBar> {
  @override
  void initState() {
    super.initState();

    // প্রোফাইল লোড না থাকলে একবার লোড করবে
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final state = ref.read(teacherProfileControllerProvider);
      if (state.profile == null && !state.isLoading) {
        try {
          await ref
              .read(teacherProfileControllerProvider.notifier)
              .loadProfile();
        } catch (_) {
          // AppBar এ এরর দেখানোর দরকার নেই
        }
      }
    });
  }

  // Handles user logout.
  Future<void> _logout() async {
    try {
      await Supabase.instance.client.auth.signOut();

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // profile is a nullable Map<String, dynamic>
    final profile = ref.watch(teacherProfileControllerProvider).profile;

    final String rawName = (profile?['full_name'] as String?)?.trim() ?? '';
    final String name = rawName.isNotEmpty ? rawName : 'Teacher';
    final String designation =
        (profile?['designation'] as String?)?.trim() ?? '';
    final String avatarUrl = (profile?['avatar_url'] as String?) ?? '';

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
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
      title: Row(
        children: [
          CircleAvatar(
            radius: 23,
            backgroundColor: Colors.white,
            backgroundImage:
            avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
            child: avatarUrl.isEmpty
                ? const Icon(Icons.person, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (designation.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    designation,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      actions: [
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
        IconButton(
          onPressed: _logout,
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
        child: Divider(height: 1, thickness: 1, color: Colors.white24),
      ),
    );
  }
}