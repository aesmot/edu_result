
import 'package:flutter/material.dart';
import 'package:result_management_system/features/teacher/model/teacher_model.dart';

class AddEditTeacherScreen extends StatefulWidget {
  final StaffModel? teacher;

  const AddEditTeacherScreen({
    super.key,
    this.teacher,
  });

  @override
  State<AddEditTeacherScreen> createState() =>
      _AddEditTeacherScreenState();
}

class _AddEditTeacherScreenState
    extends State<AddEditTeacherScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _designationController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _designationController.dispose();
    _employeeIdController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Add Teacher'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Section
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundColor: Colors.blue.shade50,
                        child: Icon(
                          Icons.person_rounded,
                          size: 42,
                          color: Colors.blue.shade600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Teacher Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Enter teacher details below',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                _buildTextField(
                  label: 'Full Name',
                  hint: 'Enter teacher name',
                  icon: Icons.person_outline,
                  controller: _nameController,
                ),

                const SizedBox(height: 16),

                _buildTextField(
                  label: 'Designation',
                  hint: 'e.g. Assistant Professor',
                  icon: Icons.work_outline,
                  controller: _designationController,
                ),

                const SizedBox(height: 16),

                _buildTextField(
                  label: 'Employee ID',
                  hint: 'e.g. FAC-MATH-014',
                  icon: Icons.badge_outlined,
                  controller: _employeeIdController,
                ),

                const SizedBox(height: 16),

                _buildTextField(
                  label: 'Email Address',
                  hint: 'Enter email address',
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                _buildTextField(
                  label: 'Phone Number',
                  hint: 'Enter phone number',
                  icon: Icons.phone_outlined,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 16),

                _buildTextField(
                  label: 'Profile Image URL',
                  hint: 'Enter image URL (optional)',
                  icon: Icons.image_outlined,
                  controller: _imageUrlController,
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save teacher logic will be added later.
                      }
                    },
                    icon: const Icon(Icons.save_rounded),
                    label: const Text(
                      'Save Teacher',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
