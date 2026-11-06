import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:result_management_system/features/action_management/widget/teacher/teacher_list_item.dart';

import '../../../shared/widgets/app_bar.dart';
import '../providers/teacher_provider.dart';

class TeacherListScreen extends ConsumerWidget {
  const TeacherListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacherAsyncValue = ref.watch(teacherListProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const UserAppBar(),
      body: teacherAsyncValue.when(
        data: (staffList) {
          // Pull-to-refresh
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(teacherListProvider);
              await ref.read(teacherListProvider.future);
            },
            child: staffList.isEmpty
                ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 200),
                Center(
                  child: Text(
                    'কোনো অনুমোদিত শিক্ষক নেই!',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ],
            )
                : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: staffList.length,
              itemBuilder: (context, index) {
                final teacher = staffList[index];
                return TeacherListItem(
                  serialNumber: index + 1,
                  name: teacher.name,
                  email: teacher.email,
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text('ডাটা লোড করতে সমস্যা হয়েছে!\n$error', textAlign: TextAlign.center),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.invalidate(teacherListProvider),
                child: const Text('আবার চেষ্টা করুন'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}