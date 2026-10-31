
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';
import 'auth_role_router.dart';
import 'login_screen.dart';

/// Determines which screen to show based on the authentication state.
class AuthGateScreen extends ConsumerWidget {
const AuthGateScreen({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
final authState = ref.watch(authControllerProvider);

return authState.when(
loading: () => const Scaffold(
body: Center(
child: CircularProgressIndicator(),
),
),
error: (error, stackTrace) => Scaffold(
body: Center(
child: Padding(
padding: const EdgeInsets.all(24),
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
const Text(
'Unable to restore your session.',
textAlign: TextAlign.center,
),
const SizedBox(height: 12),
ElevatedButton(
onPressed: () {
ref.invalidate(authControllerProvider);
},
child: const Text('Try Again'),
),
],
),
),
),
),
data: (role) {
if (role == null) {
return const LoginScreen();
}

return _DashboardRedirect(role: role);
},
);
}
}

/// Opens the correct dashboard for the authenticated user's role.
class _DashboardRedirect extends StatefulWidget {
const _DashboardRedirect({required this.role});

final String role;

@override
State<_DashboardRedirect> createState() => _DashboardRedirectState();
}

class _DashboardRedirectState extends State<_DashboardRedirect> {
@override
void initState() {
super.initState();

WidgetsBinding.instance.addPostFrameCallback((_) {
if (!mounted) return;

AuthRoleRouter.navigateByRole(
context: context,
role: widget.role,
);
});
}

@override
Widget build(BuildContext context) {
return const Scaffold(
body: Center(
child: CircularProgressIndicator(),
),
);
}
}