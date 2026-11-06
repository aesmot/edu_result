import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';
import '../widgets/login_form.dart';
import 'auth_role_router.dart';
import 'login_background.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<String?>>(
      authControllerProvider,
          (previous, next) {
        next.when(
          loading: () {},
          data: (role) {
            if (role == null || !context.mounted) return;

            AuthRoleRouter.navigateByRole(
              context: context,
              role: role,
            );
          },
          error: (error, stackTrace) {
            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  error.toString().replaceFirst('Exception: ', ''),
                ),
              ),
            );
          },
        );
      },
    );

    return LoginBackground(
      child: LoginForm(
        onLoginPressed: (email, password) async {
          await ref.read(authControllerProvider.notifier).login(
            email: email,
            password: password,
          );

          // কন্ট্রোলারে কোনো error না থাকলে success = true রিটার্ন করবে
          return !ref.read(authControllerProvider).hasError;
        },
      ),
    );
  }
}