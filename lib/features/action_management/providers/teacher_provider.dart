import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:result_management_system/features/teacher/model/teacher_model.dart';

// শুধু approved শিক্ষকদের তালিকা আনার প্রোভাইডার
final teacherListProvider =
FutureProvider.autoDispose<List<StaffModel>>((ref) async {
  final supabase = Supabase.instance.client;

  final response = await supabase
      .from('teacher_profiles')
      .select('*, profiles!inner(approval_status, role)')
      .eq('profiles.approval_status', 'approved')
      .eq('profiles.role', 'teacher')
      .order('full_name');

  return response.map((json) => StaffModel.fromJson(json)).toList();
});

// শিক্ষক যুক্ত করার Notifier Class
class TeacherNotifier extends Notifier<void> {
  @override
  void build() {}

  Future<bool> addTeacher(StaffModel teacher) async {
    try {
      final supabase = Supabase.instance.client;

      await supabase.from('teacher_profiles').insert(teacher.toJson());

      ref.invalidate(teacherListProvider);
      return true;
    } catch (e, stackTrace) {
      print('Error adding teacher: $e');
      print(stackTrace);
      return false;
    }
  }
}

final teacherControllerProvider =
NotifierProvider<TeacherNotifier, void>(TeacherNotifier.new);