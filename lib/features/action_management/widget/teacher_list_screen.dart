import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod import করুন

import 'package:result_management_system/features/action_management/widget/teacher/teacher_card_item.dart';
import 'package:result_management_system/features/action_management/screen/teacher_manage/add_edit_teacher_screen.dart';
//import 'package:result_management_system/features/teacher/provider/teacher_provider.dart'; // আপনার প্রোভাইডার ফাইল ইমপোর্ট করুন

import '../../../shared/widgets/app_bar.dart';
import '../providers/teacher_provider.dart';

// StatelessWidget এর পরিবর্তে ConsumerWidget ব্যবহার করুন যাতে ref ব্যবহার করা যায়
class TeacherListScreen extends ConsumerWidget {
  const TeacherListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // প্রোভাইডার থেকে শিক্ষকদের ডাটা ওয়াচ করা হচ্ছে
    const centerWidget = Center(child: CircularProgressIndicator());
    const errorWidget = Center(child: Text('ডাটা লোড করতে সমস্যা হয়েছে!'));

    final teacherAsyncValue = ref.watch(teacherListProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const UserAppBar(),
      body: Column(
        children: [
          // Add Teacher Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddEditTeacherScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Teacher'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),

          // Teacher List (AsyncValue দিয়ে Loading, Error এবং Data হ্যান্ডেল করা)
          Expanded(
            child: teacherAsyncValue.when(
              data: (staffList) {
                if (staffList.isEmpty) {
                  return const Center(
                    child: Text(
                      'কোনো শিক্ষক পাওয়া যায়নি!',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: staffList.length,
                  itemBuilder: (context, index) {
                    return TeacherCardItem(
                      serialNumber: index + 1,
                      staff: staffList[index],
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditTeacherScreen(
                              teacher: staffList[index], // এডিট করার জন্য ডাটা পাস করা
                            ),
                          ),
                        );
                      },
                      onDelete: () {
                        // ডিলিট লজিক এখানে যোগ করতে পারেন
                      },
                    );
                  },
                );
              },
              loading: () => centerWidget,
              error: (error, stackTrace) => errorWidget,
            ),
          ),
        ],
      ),
    );
  }
}