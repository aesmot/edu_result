import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/assign_subject_teacher.dart';
import '../../domain/repositories/assign_subject_repository.dart';
import '../../domain/models/teacher_info.dart';

class AssignSubjectClassRepository implements AssignSubjectRepository {
  final SupabaseClient _client;

  AssignSubjectClassRepository(this._client);

  @override
  Future<List<AssignSubjectTeacher>> getAllAssignments() async {
    try {
      final response = await _client
          .from('teacher_class_subjects')
          .select(
        'id, teacher_class_id, class_subject_id, '
            'teacher_classes(teacher_user_id, class_id, classes(class_name)), '
            'class_subjects(subjects(subject_name))',
      )
          .order('id');

      final profilesRes = await _client
          .from('teacher_profiles')
          .select('user_id, full_name, email');

      final profiles = <String, Map<String, dynamic>>{
        for (final p in profilesRes as List)
          p['user_id'] as String: p as Map<String, dynamic>,
      };

      final result = <AssignSubjectTeacher>[];

      for (final row in response as List) {
        final tc = row['teacher_classes'] as Map<String, dynamic>?;
        final cs = row['class_subjects'] as Map<String, dynamic>?;
        if (tc == null || cs == null) continue;

        final userId = tc['teacher_user_id'] as String;
        final profile = profiles[userId];

        final className =
        (tc['classes'] as Map<String, dynamic>?)?['class_name'] as String?;
        final subjectName =
        (cs['subjects'] as Map<String, dynamic>?)?['subject_name']
        as String?;

        final fullName = (profile?['full_name'] as String?)?.trim();

        result.add(
          AssignSubjectTeacher(
            id: (row['id'] as num).toInt(),
            teacherClassId: (row['teacher_class_id'] as num).toInt(),
            classSubjectId: (row['class_subject_id'] as num).toInt(),
            teacherUserId: userId,
            teacherName:
            (fullName != null && fullName.isNotEmpty) ? fullName : 'Unknown',
            teacherEmail: profile?['email'] as String?,
            classId: (tc['class_id'] as num).toInt(),
            className: className ?? '-',
            subjectName: subjectName ?? '-',
          ),
        );
      }

      return result;
    } on PostgrestException catch (e) {
      throw Exception('Assignment আনতে সমস্যা হয়েছে: ${e.message}');
    }
  }

  @override
  Future<void> deleteAssignment(int assignmentId) async {
    try {
      final deleted = await _client
          .from('teacher_class_subjects')
          .delete()
          .eq('id', assignmentId)
          .select();

      if ((deleted as List).isEmpty) {
        throw Exception('মোছা যায়নি (delete policy মিলছে না)');
      }
    } on PostgrestException catch (e) {
      throw Exception('মুছতে সমস্যা হয়েছে: ${e.message}');
    }
  }

  ////////////////
  @override
  Future<List<TeacherInfo>> getTeachers() async {
    try {
      final response = await _client
          .from('teacher_profiles')
      // এখন
          .select('user_id, full_name, designation')
          .order('full_name');

      return (response as List)
          .map((row) => TeacherInfo.fromJson(row as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      throw Exception('Teacher তালিকা আনতে সমস্যা হয়েছে: ${e.message}');
    }
  }
  ///////////////
  @override
  Future<void> assignSubject({
    required String teacherUserId,
    required int classId,
    required int subjectId,
  }) async {
    try {
      // ১. ক্লাসে subject টা আছে কিনা, আর class_subject_id কত
      final cs = await _client
          .from('class_subjects')
          .select('class_subject_id')
          .eq('class_id', classId)
          .eq('subject_id', subjectId)
          .maybeSingle();
      if (cs == null) {
        throw Exception('এই ক্লাসে subject টি পাওয়া যায়নি');
      }
      final classSubjectId = (cs['class_subject_id'] as num).toInt();

      // ২. teacher_classes এ জোড়া আছে কিনা, না থাকলে বানানো
      final existing = await _client
          .from('teacher_classes')
          .select('id')
          .eq('teacher_user_id', teacherUserId)
          .eq('class_id', classId)
          .maybeSingle();

      int teacherClassId;
      if (existing != null) {
        teacherClassId = (existing['id'] as num).toInt();
      } else {
        final inserted = await _client
            .from('teacher_classes')
            .insert({'teacher_user_id': teacherUserId, 'class_id': classId})
            .select('id')
            .single();
        teacherClassId = (inserted['id'] as num).toInt();
      }

      // ৩. duplicate চেক
      final dup = await _client
          .from('teacher_class_subjects')
          .select('id')
          .eq('teacher_class_id', teacherClassId)
          .eq('class_subject_id', classSubjectId)
          .maybeSingle();
      if (dup != null) {
        throw Exception('এই subject আগেই assign করা আছে');
      }

      // ৪. assign
      await _client.from('teacher_class_subjects').insert({
        'teacher_class_id': teacherClassId,
        'class_subject_id': classSubjectId,
      });
    } on PostgrestException catch (e) {
      throw Exception('Assign করতে সমস্যা হয়েছে: ${e.message}');
    }
  }

  @override
  Future<void> deleteClassAssignment({
    required String teacherUserId,
    required int classId,
  }) async {
    try {
      final tc = await _client
          .from('teacher_classes')
          .select('id')
          .eq('teacher_user_id', teacherUserId)
          .eq('class_id', classId)
          .maybeSingle();
      if (tc == null) return;
      final teacherClassId = (tc['id'] as num).toInt();

      // আগে subject গুলো
      await _client
          .from('teacher_class_subjects')
          .delete()
          .eq('teacher_class_id', teacherClassId);

      // তারপর ক্লাস
      final deleted = await _client
          .from('teacher_classes')
          .delete()
          .eq('id', teacherClassId)
          .select();
      if ((deleted as List).isEmpty) {
        throw Exception('মোছা যায়নি (delete policy মিলছে না)');
      }
    } on PostgrestException catch (e) {
      throw Exception('ক্লাস মুছতে সমস্যা হয়েছে: ${e.message}');
    }
  }
}