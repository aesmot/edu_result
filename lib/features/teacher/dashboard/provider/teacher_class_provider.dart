import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ---------------------------------------------------------------------------
// Models
// ---------------------------------------------------------------------------

/// classes table এর একটি ক্লাস (Add Class ড্রপডাউনের জন্য)
class ClassOption {
  const ClassOption({required this.id, required this.name});

  final int id;
  final String name;
}

/// class_subjects table এর একটি সারি: কোন ক্লাসে কোন বিষয় (বিষয় ড্রপডাউনের জন্য)
class SubjectOption {
  const SubjectOption({
    required this.classSubjectId,
    required this.classId,
    required this.name,
  });

  final int classSubjectId;
  final int classId;
  final String name;
}

/// classes, subjects ও class_subjects এর স্থির তালিকা
class ClassCatalog {
  const ClassCatalog({required this.classes, required this.subjects});

  final List<ClassOption> classes;
  final List<SubjectOption> subjects;
}

/// শিক্ষকের বাছা একটি বিষয় (teacher_class_subjects এর সারি)
class TeacherSubject {
  const TeacherSubject({
    required this.id,
    required this.classSubjectId,
    required this.name,
  });

  final int id;
  final int classSubjectId;
  final String name;
}

/// শিক্ষকের যোগ করা একটি ক্লাস (teacher_classes এর সারি) ও তার বিষয়গুলো
class TeacherClass {
  const TeacherClass({
    required this.id,
    required this.classId,
    required this.className,
    required this.subjects,
  });

  final int id;
  final int classId;
  final String className;
  final List<TeacherSubject> subjects;
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

/// classes, subjects ও class_subjects একবারই আনা হয় (প্রায় স্থির ডাটা)
final classCatalogProvider = FutureProvider<ClassCatalog>((ref) async {
  final supabase = Supabase.instance.client;

  final classesRes = await supabase
      .from('classes')
      .select('class_id, class_name')
      .order('class_id');

  final subjectsRes =
  await supabase.from('subjects').select('subject_id, subject_name');

  final classSubjectsRes = await supabase
      .from('class_subjects')
      .select('class_subject_id, class_id, subject_id');

  final subjectNames = {
    for (final s in subjectsRes)
      (s['subject_id'] as num).toInt(): (s['subject_name'] as String?) ?? '',
  };

  final classes = classesRes
      .map<ClassOption>(
        (c) => ClassOption(
      id: (c['class_id'] as num).toInt(),
      name: (c['class_name'] as String?) ?? '',
    ),
  )
      .toList();

  final subjects = classSubjectsRes
      .map<SubjectOption>(
        (cs) => SubjectOption(
      classSubjectId: (cs['class_subject_id'] as num).toInt(),
      classId: (cs['class_id'] as num).toInt(),
      name: subjectNames[(cs['subject_id'] as num).toInt()] ?? '',
    ),
  )
      .where((s) => s.name.isNotEmpty)
      .toList();

  return ClassCatalog(classes: classes, subjects: subjects);
});

/// লগইন করা শিক্ষকের যোগ করা ক্লাস ও বিষয়
final teacherClassesProvider =
FutureProvider.autoDispose<List<TeacherClass>>((ref) async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  if (user == null) throw Exception('লগইন করা নেই');

  final catalog = await ref.watch(classCatalogProvider.future);

  final rows = await supabase
      .from('teacher_classes')
      .select('id, class_id, teacher_class_subjects(id, class_subject_id)')
      .eq('teacher_user_id', user.id)
      .order('class_id');

  final classNames = {for (final c in catalog.classes) c.id: c.name};
  final subjectNames = {
    for (final s in catalog.subjects) s.classSubjectId: s.name,
  };

  return rows.map<TeacherClass>((row) {
    final classId = (row['class_id'] as num).toInt();
    final rawSubjects = (row['teacher_class_subjects'] as List?) ?? const [];

    final subjects = rawSubjects
        .map<TeacherSubject>(
          (s) => TeacherSubject(
        id: (s['id'] as num).toInt(),
        classSubjectId: (s['class_subject_id'] as num).toInt(),
        name: subjectNames[(s['class_subject_id'] as num).toInt()] ?? '',
      ),
    )
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));

    return TeacherClass(
      id: (row['id'] as num).toInt(),
      classId: classId,
      className: classNames[classId] ?? 'Class $classId',
      subjects: subjects,
    );
  }).toList();
});

// ---------------------------------------------------------------------------
// Controller: ক্লাস/বিষয় যোগ ও মোছা
// ---------------------------------------------------------------------------

class TeacherClassController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  SupabaseClient get _supabase => Supabase.instance.client;

  /// সফল হলে true। ব্যর্থ হলে false, আর কারণ state.error তে থাকে।
  Future<bool> _run(Future<void> Function() action) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await action();
      ref.invalidate(teacherClassesProvider);
    });
    return !state.hasError;
  }

  String _uid() {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('লগইন করা নেই');
    return user.id;
  }

  Future<bool> addClass(int classId) => _run(() async {
    await _supabase.from('teacher_classes').insert({
      'teacher_user_id': _uid(),
      'class_id': classId,
    });
  });

  /// ক্লাস মুছলে তার বিষয়গুলোও নিজে মুছে যায় (database cascade)
  Future<bool> removeClass(int teacherClassId) => _run(() async {
    await _supabase
        .from('teacher_classes')
        .delete()
        .eq('id', teacherClassId);
  });

  Future<bool> addSubject({
    required int teacherClassId,
    required int classSubjectId,
  }) =>
      _run(() async {
        await _supabase.from('teacher_class_subjects').insert({
          'teacher_class_id': teacherClassId,
          'class_subject_id': classSubjectId,
        });
      });

  Future<bool> removeSubject(int teacherClassSubjectId) => _run(() async {
    await _supabase
        .from('teacher_class_subjects')
        .delete()
        .eq('id', teacherClassSubjectId);
  });
}

final teacherClassControllerProvider =
AsyncNotifierProvider<TeacherClassController, void>(
  TeacherClassController.new,
);
