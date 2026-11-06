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
        // শুধু loading থেকে data তে গেলে চালান, নাহলে বারবার trigger হতে পারে
        if (previous is AsyncLoading && next is AsyncData<String?>) {
          if (!context.mounted) return;
          final role = next.value;

          if (role == null) {
            // Approval pending
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account তৈরি হয়েছে! Admin approval এর জন্য অপেক্ষা করুন।'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 4),
              ),
            );
            // এখানে চাইলে login screen এ ফেরত যেতে পারেন:
            // Navigator.pop(context);
          } else {
            AuthRoleRouter.navigateByRole(context: context, role: role);
          }
        }

        if (next is AsyncError) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                next.error.toString().replaceFirst('Exception: ', ''),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
    return LoginBackground(
      child: SignUpForm(
        onLoginPressed: () {
          // Login screen-e fire jawar jonno
          Navigator.pop(context);
        },
        onSignupSubmitted: (name, identifier, password) async {
          await ref.read(authControllerProvider.notifier).signup(
            name: name,
            identifier: identifier,
            password: password,
          );

          // signup সফল হলে true, error হলে false
          return !ref.read(authControllerProvider).hasError;
        },
      ),
    );
  }
}