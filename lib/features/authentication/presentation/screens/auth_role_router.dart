
import 'package:flutter/material.dart';

import '../../../admin/screens/admin_screen.dart';
import '../../../teacher/dashboard/screens/teacher_dashboard_screen.dart';

/// Routes authenticated users to their assigned dashboard.
class AuthRoleRouter {
  AuthRoleRouter._();

  static void navigateByRole({
    required BuildContext context,
    required String role,
  }) {
    final Widget screen;

    switch (role) {
      case 'admin':
        screen = const AdminScreen();
        break;

      case 'teacher':
        screen = TeacherDashboardScreen();
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No valid role assigned to this account.'),
          ),
        );
        return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => screen,
      ),
          (route) => false,
    );
  }
}
