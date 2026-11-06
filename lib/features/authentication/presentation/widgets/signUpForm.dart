import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';
import 'authInput_decoration.dart';
import 'auth_button.dart';
import 'auth_footer.dart';
import 'auth_method_button.dart'; // আলাদা করা মেথড বাটন ইমপোর্ট
// AuthInputDecoration ফাইলটি ইমপোর্ট করুন (যদি আলাদা ফাইলে রাখেন)

class SignUpForm extends StatefulWidget {
  final VoidCallback onLoginPressed;
  // নতুন একটি ফাংশন যোগ করুন যা ডেটা রিসিভ করবে:
  final Function(String name, String identifier, String password) onSignupSubmitted;

  const SignUpForm({
    super.key,
    required this.onLoginPressed,
    required this.onSignupSubmitted, // এখানে রিকোয়ার্ড করুন
  });
// ...


  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isEmailSelected = true;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _identifierController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    if (!_formKey.currentState!.validate()) return;

    // কন্ট্রোলার থেকে টেক্সট নিয়ে পাস করে দেওয়া হচ্ছে
    widget.onSignupSubmitted(
      _nameController.text.trim(),
      _identifierController.text.trim(),
      _passwordController.text,
    );
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
      child: Form(
        key: _formKey,
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

            // Name Field
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: AuthInputDecoration.getDecoration(
                label: 'Name',
                icon: Icons.person,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),

            // Signup Method Selection (Using separate widget)
            Row(
              children: [
                Expanded(
                  child: AuthMethodButton(
                    title: 'Email',
                    icon: Icons.email,
                    isSelected: _isEmailSelected,
                    onTap: () {
                      setState(() {
                        _isEmailSelected = true;
                        _identifierController.clear();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AuthMethodButton(
                    title: 'Mobile Number',
                    icon: Icons.phone_android,
                    isSelected: !_isEmailSelected,
                    onTap: () {
                      setState(() {
                        _isEmailSelected = false;
                        _identifierController.clear();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Email / Mobile Number Field
            TextFormField(
              controller: _identifierController,
              keyboardType: _isEmailSelected ? TextInputType.emailAddress : TextInputType.phone,
              decoration: AuthInputDecoration.getDecoration(
                label: _isEmailSelected ? 'Email' : 'Mobile Number',
                icon: _isEmailSelected ? Icons.email : Icons.numbers,
              ),
              validator: (value) {
                final input = value?.trim() ?? '';
                if (input.isEmpty) {
                  return _isEmailSelected ? 'Please enter your email' : 'Please enter your mobile number';
                }
                if (_isEmailSelected && !RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(input)) {
                  return 'Please enter a valid email';
                }
                if (!_isEmailSelected && !RegExp(r'^\+?[0-9]{10,15}$').hasMatch(input)) {
                  return 'Please enter a valid mobile number';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),

            // Password Field
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: AuthInputDecoration.getDecoration(
                label: 'Password',
                icon: Icons.lock,
              ).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),

            // Confirm Password Field
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              decoration: AuthInputDecoration.getDecoration(
                label: 'Confirm Password',
                icon: Icons.lock,
              ).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Signup Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: AuthButton(
                text: 'Sign Up',
                onPressed: _handleSignup,
              ),
            ),
            const SizedBox(height: 20),

            // Login Footer
            AuthFooter(
              titleText: 'Already have an account? ',
              actionText: 'LogIn',
              onTap: widget.onLoginPressed,
            ),
          ],
        ),
      ),
    );
  }
}