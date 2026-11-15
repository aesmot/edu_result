import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// আপনার প্রজেক্টের path অনুযায়ী মিলিয়ে নিন
import '../controller/teacher_profile_controller.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _designationController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  @override
  void dispose() {
    _designationController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // প্রোফাইল আগে লোড না হয়ে থাকলে লোড করে, তারপর ফিল্ডে বসায়
  Future<void> _init() async {
    final notifier = ref.read(teacherProfileControllerProvider.notifier);

    try {
      if (ref.read(teacherProfileControllerProvider).profile == null) {
        await notifier.loadProfile();
      }
    } catch (e) {
      if (mounted) {
        _showMessage('প্রোফাইল লোড করতে সমস্যা হয়েছে!\n$e', isError: true);
      }
    }

    if (!mounted) return;

    final profile = ref.read(teacherProfileControllerProvider).profile;
    _designationController.text = (profile?['designation'] as String?) ?? '';
    _phoneController.text = (profile?['phone'] as String?) ?? '';

    setState(() => _initialized = true);
  }

  Future<void> _save() async {
    try {
      await ref.read(teacherProfileControllerProvider.notifier).saveProfile(
        designation: _designationController.text,
        phone: _phoneController.text,
      );

      if (!mounted) return;
      _showMessage('প্রোফাইল সেভ হয়েছে');
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().replaceFirst('Exception: ', '');
      _showMessage('সেভ করতে সমস্যা হয়েছে!\n$msg', isError: true);
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
    final state = ref.watch(teacherProfileControllerProvider);

    if (!_initialized || state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final profile = state.profile;
    final user = Supabase.instance.client.auth.currentUser;

    final name = (profile?['full_name'] as String?) ?? '';
    final email = (profile?['email'] as String?) ?? user?.email ?? '';
    final avatarUrl = (profile?['avatar_url'] as String?) ?? '';

    ImageProvider? avatarImage;
    if (state.pickedImage != null) {
      avatarImage = MemoryImage(state.pickedImage!);
    } else if (avatarUrl.isNotEmpty) {
      avatarImage = NetworkImage(avatarUrl);
    }

    final initial =
    name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : '?';

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
                  onTap: () => ref
                      .read(teacherProfileControllerProvider.notifier)
                      .pickImage(),
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFF2563EB),
                    child:
                    Icon(Icons.camera_alt, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // নাম ও ইমেইল (শুধু দেখানো)
          Text(
            name.isNotEmpty ? name : 'নাম নেই',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            email.isNotEmpty ? email : 'ইমেইল নেই',
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
              onPressed: state.isSaving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: state.isSaving
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