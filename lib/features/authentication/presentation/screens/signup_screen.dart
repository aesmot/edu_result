import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';
import '../widgets/signUpForm.dart';
import 'auth_role_router.dart';
import 'login_background.dart';
import 'login_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    // Controller-er state listen korchi (Error ba Success handle korar jonno)
    ref.listen<AsyncValue<String?>>(
      authControllerProvider,
          (previous, next) {
        next.when(
          loading: () {},
          data: (role) {
            if (role == null || !context.mounted) return;

            // Signup successful hole role onujayi dashboard-e niye jabe
            AuthRoleRouter.navigateByRole(
              context: context,
              role: role,
            );
          },
          error: (error, stackTrace) {
            if (!context.mounted) return;

            // Kono error asle SnackBar-e show korbe
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
      child: SignUpForm(
        onLoginPressed: () {
          // Login screen-e fire jawar jonno
          Navigator.pop(context);
        },
        onSignupSubmitted: (name, identifier, password) async {
          // Riverpod notifier er maddhome signup method call korchi
          await ref.read(authControllerProvider.notifier).signup(
            name: name,
            identifier: identifier,
            password: password,
          );
        },
      ),
    );
  }
}