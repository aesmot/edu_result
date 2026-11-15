import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// validation ফলাফল: হয় rows, নয় errorMessage
class MarkValidation {
  const MarkValidation({this.rows = const [], this.errorMessage});

  final List<Map<String, dynamic>> rows;
  final String? errorMessage;

  bool get hasError => errorMessage != null;
}

class MarkService {
  static const int mcqMax = 25;
  static const int theoryMax = 50;
  static const int practicalMax = 25;

  static SupabaseClient get _db => Supabase.instance.client;

  /// student_id -> সেভ করা মার্কের সারি
  static Future<Map<int, Map<String, dynamic>>> fetch({
    required String examinationId,
    required int classSubjectId,
  }) async {
    final rows = await _db
        .from('marks')
        .select('student_id, mcq_marks, written_marks, practical_marks')
        .eq('examination_id', examinationId)
        .eq('class_subject_id', classSubjectId);

    return {for (final r in rows) (r['student_id'] as num).toInt(): r};
  }

  /// খালি হলে null, সংখ্যা না হলে বা সীমার বাইরে হলে error
  static ({num? value, bool ok}) _parse(String text, int max) {
    final t = text.trim();
    if (t.isEmpty) return (value: null, ok: true);
    final v = num.tryParse(t);
    if (v == null || v < 0 || v > max) return (value: null, ok: false);
    return (value: v, ok: true);
  }

  /// ছাত্রদের তালিকা যাচাই করে Supabase-এর rows বানায়
  static MarkValidation buildRows({
    required List<
        ({
        int studentId,
        String roll,
        String mcq,
        String theory,
        String practical,
        })> students,
    required String examinationId,
    required int classSubjectId,
  }) {
    final rows = <Map<String, dynamic>>[];
    final badRolls = <String>[];
    final uid = _db.auth.currentUser?.id;
    final now = DateTime.now().toUtc().toIso8601String();

    for (final s in students) {
      final mcq = _parse(s.mcq, mcqMax);
      final theory = _parse(s.theory, theoryMax);
      final practical = _parse(s.practical, practicalMax);

      final allEmpty =
          mcq.value == null && theory.value == null && practical.value == null;

      if (!mcq.ok || !theory.ok || !practical.ok) {
        badRolls.add(s.roll);
        continue;
      }
      if (allEmpty) continue; // কিছু লেখা নেই, বাদ

      rows.add({
        'student_id': s.studentId,
        'class_subject_id': classSubjectId,
        'examination_id': examinationId,
        'mcq_marks': mcq.value,
        'written_marks': theory.value,
        'practical_marks': practical.value,
        'created_by': uid,
        'updated_at': now,
      });
    }

    if (badRolls.isNotEmpty) {
      return MarkValidation(
        errorMessage:
        'রোল ${badRolls.join(', ')}: মার্ক ভুল বা সীমার বাইরে (MCQ $mcqMax, Theory $theoryMax, Practical $practicalMax)',
      );
    }
    if (rows.isEmpty) {
      return const MarkValidation(
        errorMessage: 'কোনো ছাত্রের মার্ক লেখা হয়নি',
      );
    }
    return MarkValidation(rows: rows);
  }

  static Future<void> save(List<Map<String, dynamic>> rows) async {
    await _db.from('marks').upsert(
      rows,
      onConflict: 'student_id,class_subject_id,examination_id',
    );
  }
}