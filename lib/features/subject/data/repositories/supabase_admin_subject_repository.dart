import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/models/class_subjects.dart';
import '../../domain/models/subject.dart';
import '../../domain/repositories/admin_subject_repository.dart';

/// Admin এর জন্য Supabase repository।
class SupabaseAdminSubjectRepository implements AdminSubjectRepository {
  final SupabaseClient _client;

  SupabaseAdminSubjectRepository(this._client);

  /// সব ক্লাস ও তাদের subject।
  @override
  Future<List<ClassSubjects>> getAllClassSubjects() async {
    try {
      final response = await _client
          .from('classes')
          .select(
        'class_id, class_name, '
            'class_subjects(subjects(subject_id, subject_name))',
      )
          .order('class_id');

      final result = <ClassSubjects>[];

      for (final row in response as List) {
        final classId = (row['class_id'] as num).toInt();

        final subjects = <Subject>[];
        for (final cs in (row['class_subjects'] as List? ?? const [])) {
          final subjectJson = cs['subjects'] as Map<String, dynamic>?;
          if (subjectJson == null) continue;
          subjects.add(
            Subject.fromJson(subjectJson, classId: classId.toString()),
          );
        }
        subjects.sort((a, b) => a.name.compareTo(b.name));

        result.add(ClassSubjects(
          classId: classId,
          className: row['class_name'] as String,
          subjects: subjects,
        ));
      }

      return result;
    } on PostgrestException catch (e) {
      throw Exception('ক্লাসের সাবজেক্ট আনতে সমস্যা হয়েছে: ${e.message}');
    }
  }

  /// Add dialog এর জন্য সব subject।
  @override
  Future<List<Subject>> getAllSubjects() async {
    try {
      final response = await _client
          .from('subjects')
          .select('subject_id, subject_name')
          .order('subject_name');

      return (response as List)
          .map((row) => Subject.fromJson(row as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      throw Exception('সাবজেক্ট লিস্ট আনতে সমস্যা হয়েছে: ${e.message}');
    }
  }

  /// ক্লাসে subject যোগ করে।
  @override
  Future<void> addSubjectToClass(int classId, int subjectId) async {
    try {
      final existing = await _client
          .from('class_subjects')
          .select('class_subject_id')
          .eq('class_id', classId)
          .eq('subject_id', subjectId)
          .maybeSingle();

      if (existing != null) {
        throw Exception('এই সাবজেক্ট ক্লাসে আগে থেকেই আছে');
      }

      await _client.from('class_subjects').insert({
        'class_id': classId,
        'subject_id': subjectId,
      });
    } on PostgrestException catch (e) {
      throw Exception('সাবজেক্ট যোগ করতে সমস্যা হয়েছে: ${e.message}');
    }
  }

  /// ক্লাস থেকে subject সরায়। Marks থাকলে মোছা যাবে না।
  @override
  @override
  Future<void> removeSubjectFromClass(int classId, int subjectId) async {
    try {
      final row = await _client
          .from('class_subjects')
          .select('class_subject_id')
          .eq('class_id', classId)
          .eq('subject_id', subjectId)
          .maybeSingle();

      if (row == null) {
        throw Exception('সাবজেক্টটি খুঁজে পাওয়া যায়নি (select policy চেক করুন)');
      }
      final classSubjectId = row['class_subject_id'];

      final marks = await _client
          .from('marks')
          .select('mark_id')
          .eq('class_subject_id', classSubjectId)
          .limit(1);

      if ((marks as List).isNotEmpty) {
        throw Exception('এই সাবজেক্টের marks আছে, তাই মোছা যাবে না');
      }

      await _client
          .from('teacher_class_subjects')
          .delete()
          .eq('class_subject_id', classSubjectId);

      final deleted = await _client
          .from('class_subjects')
          .delete()
          .eq('class_subject_id', classSubjectId)
          .select();

      if ((deleted as List).isEmpty) {
        throw Exception('মোছা যায়নি (delete policy মিলছে না)');
      }
    } on PostgrestException catch (e) {
      throw Exception('সাবজেক্ট মুছতে সমস্যা হয়েছে: ${e.message}');
    }
  }
}