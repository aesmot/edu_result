import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';
import 'auth_button.dart';
import 'auth_footer.dart';

class SignUpForm extends StatefulWidget {
  final VoidCallback onLoginPressed;

  const SignUpForm({
    super.key,
    required this.onLoginPressed,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'SignUp',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.authText,
            ),
          ),
          const SizedBox(height: 20),

          // Email Field
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Name',
              prefixIcon: const Icon(Icons.email),
              prefixIconColor: AppColors.authText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFF14B8A6),
                  width: 1,
                ),

              ),
            ),
          ),
          const SizedBox(height: 15),

          // Mobile Number Field
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Mobile Number',
              prefixIcon: const Icon(Icons.numbers),
              prefixIconColor: AppColors.authText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFF14B8A6),
                  width: 1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Password Field
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              prefixIconColor: AppColors.authText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFF14B8A6),
                  width: 1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Confirm Password Field
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: const Icon(Icons.lock),
              prefixIconColor: AppColors.authText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFF14B8A6),
                  width: 1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),


          // Login Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: AuthButton(
              text: 'Login',
              onPressed: () {
                // Login logic will go here.
                debugPrint('Login button pressed');
              },
            ),
          ),


          const SizedBox(height: 20),
          // Nicher Text ba Sign Up link
          AuthFooter(
            titleText: "Already have an account? ",
            actionText: "LogIn",
            onTap: () {
              // SignUpScreen-e jawar logic
            },
          ),  ////////Under portion text end
        ],
      ),
    );
  }
}