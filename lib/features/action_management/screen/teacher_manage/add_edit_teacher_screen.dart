import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:result_management_system/features/teacher/model/teacher_model.dart';
import '../../providers/teacher_provider.dart';

class AddEditTeacherScreen extends ConsumerStatefulWidget {
  final StaffModel? teacher;

  const AddEditTeacherScreen({
    super.key,
    this.teacher,
  });

  @override
  ConsumerState<AddEditTeacherScreen> createState() =>
      _AddEditTeacherScreenState();
}

class _AddEditTeacherScreenState extends ConsumerState<AddEditTeacherScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _designationController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _imageUrlController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // যদি এডিট করার জন্য শিক্ষক পাস করা হয়, তবে ফিল্ডগুলোতে আগের ডাটা বসিয়ে দেওয়া হবে
    _nameController = TextEditingController(text: widget.teacher?.name ?? '');
    _designationController = TextEditingController(text: widget.teacher?.designation ?? '');
    _emailController = TextEditingController(text: widget.teacher?.email ?? '');
    _phoneController = TextEditingController(text: widget.teacher?.phone ?? '');
    _imageUrlController = TextEditingController(text: widget.teacher?.imageUrl ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _designationController.dispose();
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
    bool isOptional = false,
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
            if (isOptional) {
              return null;
            }
            if (value == null || value.trim().isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  // Supabase-এ সেভ করার ফাংশন
  // Supabase-এ সেভ করার ফাংশন
  Future<void> _saveTeacher() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final newTeacher = StaffModel(
      // যদি এডিট হয় তবে আইডি যাবে, নতুন হলে خالی স্ট্রিংয়ের বদলে null বা ড্রপ করতে হবে
      // অথবা ডাটাবেজে id অটো জেনারেট হওয়ার সুযোগ দিতে হবে
      id: widget.teacher?.id ?? '',
      userId: Supabase.instance.client.auth.currentUser?.id,
      name: _nameController.text.trim(),
      designation: _designationController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      imageUrl: _imageUrlController.text.trim().isEmpty
          ? null
          : _imageUrlController.text.trim(),
    );

    // Riverpod provider এর মাধ্যমে Supabase-এ ডাটা পাঠানো
    final success = await ref
        .read(teacherControllerProvider.notifier)
        .addTeacher(newTeacher);


    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Teacher saved successfully!')),
      );
      Navigator.pop(context);
    } else {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save teacher.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.teacher != null;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Teacher' : 'Add Teacher'),
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

                // Profile Image URL (অপশনাল ফিল্ড)
                _buildTextField(
                  label: 'Profile Image URL',
                  hint: 'Enter image URL (optional)',
                  icon: Icons.image_outlined,
                  controller: _imageUrlController,
                  isOptional: true,
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _saveTeacher,
                    icon: _isLoading
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                        : const Icon(Icons.save_rounded),
                    label: Text(
                      _isLoading ? 'Saving...' : 'Save Teacher',
                      style: const TextStyle(
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