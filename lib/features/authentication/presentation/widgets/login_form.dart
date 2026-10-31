import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';
import 'auth_button.dart';
import 'auth_footer.dart';

class LoginForm extends StatefulWidget {
  final Future<void> Function(String email, String password)
  onLoginPressed;

  const LoginForm({
    super.key,
    required this.onLoginPressed,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = true;
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter email and password.'),
        ),
      );
      return;
    }

    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      await widget.onLoginPressed(email, password);

      if (mounted) {
        _passwordController.clear();
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
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
            'Login',
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
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
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

          // Password Field

          TextField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              prefixIconColor: AppColors.authText,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFF14B8A6),
                  width: 1,
                ),
              ),
            ),
          ),


          // Forgot Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text( // Ekhane theke 'const' ta kete dite hobe
                'Forgot Password?',
                style: AppTypography.actionText.copyWith(
                  color: AppColors.authText,
                ), // Ekhane copyWith er bracket close holo
              ), // Ekhane Text widget close holo
            ),
          ),

          const SizedBox(height: 20),

          // Login Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child:
            AuthButton(
              text: _isLoading ? 'Logging in...' : 'Login',
              onPressed: _handleLogin,
              isLoading: _isLoading,
            ),
          ),
          const SizedBox(height: 20),
          // Nicher Text ba Sign Up link
          AuthFooter(
            titleText: "Don't have an account? ",
            actionText: "Sign Up",
            onTap: () {
              // SignUpScreen-e jawar logic
            },
          ),
           ////////Under portion text end

        ],
      ),
    );
  }
}