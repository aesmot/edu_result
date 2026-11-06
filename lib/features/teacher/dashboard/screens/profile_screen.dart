import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _supabase = Supabase.instance.client;
  final _designationController = TextEditingController();
  final _phoneController = TextEditingController();

  String _name = '';
  String _email = '';
  String? _avatarUrl;
  File? _pickedImage;

  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _designationController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // লগইন করা ইউজারের uid দিয়ে নিজের row আনা
  Future<void> _loadProfile() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw Exception('লগইন করা নেই');

      final data = await _supabase
          .from('teacher_profiles')
          .select('full_name, email, designation, phone, avatar_url')
          .eq('user_id', user.id)
          .maybeSingle();

      if (!mounted) return;
      setState(() {
        _name = (data?['full_name'] as String?) ?? '';
        _email = (data?['email'] as String?) ?? user.email ?? '';
        _designationController.text = (data?['designation'] as String?) ?? '';
        _phoneController.text = (data?['phone'] as String?) ?? '';
        _avatarUrl = data?['avatar_url'] as String?;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showMessage('প্রোফাইল লোড করতে সমস্যা হয়েছে!\n$e', isError: true);
    }
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 800,
    );
    if (picked != null) {
      setState(() => _pickedImage = File(picked.path));
    }
  }

  // সব ফিল্ড অপশনাল: শুধু যেগুলো পূরণ করা হয়েছে সেগুলো আপডেট হবে
  Future<void> _save() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    final designation = _designationController.text.trim();
    final phone = _phoneController.text.trim();

    final updates = <String, dynamic>{
      if (designation.isNotEmpty) 'designation': designation,
      if (phone.isNotEmpty) 'phone': phone,
      // TODO: ছবি আপলোড করে avatar_url এখানে যোগ করতে হবে (Storage bucket ঠিক হলে)
    };

    if (updates.isEmpty) {
      _showMessage('কিছু পূরণ করা হয়নি');
      return;
    }

    setState(() => _isSaving = true);
    try {
      await _supabase
          .from('teacher_profiles')
          .update(updates)
          .eq('user_id', user.id);

      if (!mounted) return;
      _showMessage('প্রোফাইল সেভ হয়েছে');
    } catch (e) {
      if (!mounted) return;
      _showMessage('সেভ করতে সমস্যা হয়েছে!\n$e', isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showMessage(String text, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    ImageProvider? avatarImage;
    if (_pickedImage != null) {
      avatarImage = FileImage(_pickedImage!);
    } else if (_avatarUrl != null && _avatarUrl!.isNotEmpty) {
      avatarImage = NetworkImage(_avatarUrl!);
    }

    final initial = _name.trim().isNotEmpty ? _name.trim()[0].toUpperCase() : '?';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 8),

          // ছবি
          Stack(
            children: [
              CircleAvatar(
                radius: 52,
                backgroundColor: const Color(0xFFDBEAFE),
                backgroundImage: avatarImage,
                child: avatarImage == null
                    ? Text(
                  initial,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2563EB),
                  ),
                )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: _pickImage,
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFF2563EB),
                    child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // নাম ও ইমেইল (শুধু দেখানো, বদলানো যাবে না)
          Text(
            _name.isNotEmpty ? _name : 'নাম নেই',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            _email.isNotEmpty ? _email : 'ইমেইল নেই',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),

          // পদবী (অপশনাল)
          TextField(
            controller: _designationController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'পদবী (ঐচ্ছিক)',
              prefixIcon: const Icon(Icons.work_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // মোবাইল নম্বর (অপশনাল)
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'মোবাইল নম্বর (ঐচ্ছিক)',
              prefixIcon: const Icon(Icons.phone_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _isSaving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isSaving
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text('সেভ করুন'),
            ),
          ),
        ],
      ),
    );
  }
}