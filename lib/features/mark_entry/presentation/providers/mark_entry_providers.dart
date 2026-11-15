import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/student/presentation/providers/student_provider.dart';
import '../controllers/mark_service.dart';
import '../controllers/student_marks_ui.dart';


/// provider-এর আর্গুমেন্ট (record, তাই == নিজে থেকেই কাজ করে)
typedef MarkEntryArgs = ({
String examinationId,
int classSubjectId,
int classId,
});

/// সেভের ফলাফল: UI শুধু message দেখাবে
class MarkSaveResult {
  const MarkSaveResult.success(this.message) : ok = true;
  const MarkSaveResult.failure(this.message) : ok = false;

  final bool ok;
  final String message;
}

/// স্ক্রিনের অবস্থা
class MarkEntryState {
  const MarkEntryState({
    required this.students,
    required this.isEditing,
    this.isSaving = false,
    this.tick = 0,
  });

  final List<StudentMarksUI> students;
  final bool isEditing;
  final bool isSaving;

  /// মার্ক লিখলে বাড়ে, যাতে UI নতুন করে আঁকে
  final int tick;

  MarkEntryState copyWith({bool? isEditing, bool? isSaving, int? tick}) {
    return MarkEntryState(
      students: students,
      isEditing: isEditing ?? this.isEditing,
      isSaving: isSaving ?? this.isSaving,
      tick: tick ?? this.tick,
    );
  }

  /// যত ঘরে মার্ক আছে, শুধু সেগুলোর যোগফল। সব খালি হলে null।
  int? totalOf(StudentMarksUI s) {
    final values = [
      s.mcqController.text,
      s.theoryController.text,
      s.practicalController.text,
    ].map((t) => num.tryParse(t.trim())).whereType<num>();

    if (values.isEmpty) return null;
    return values.fold<num>(0, (a, b) => a + b).toInt();
  }

  /// অন্তত একটি ঘরে মার্ক আছে এমন ছাত্রের সংখ্যা
  int get enteredCount => students.where((s) => totalOf(s) != null).length;
}

class MarkEntryNotifier extends AsyncNotifier<MarkEntryState> {
  MarkEntryNotifier(this.args);

  final MarkEntryArgs args;

  String _fmt(dynamic v) => v == null
      ? ''
      : (v as num).toString().replaceAll(RegExp(r'\.0$'), '');

  @override
  Future<MarkEntryState> build() async {
    // ১. ছাত্র তালিকা
    final serverStudents =
    await ref.read(studentsByClassProvider(args.classId).future);

    final students = [
      for (final s in serverStudents)
        StudentMarksUI(
          roll: s.rollNumber,
          name: s.name,
          mcq: '',
          theory: '',
          practical: '',
          studentId: s.id,
        ),
    ];

    // provider বন্ধ হলে controller গুলো মুছে ফেলা
    ref.onDispose(() {
      for (final s in students) {
        s.dispose();
      }
    });

    // ২. সেভ করা মার্ক
    final saved = await MarkService.fetch(
      examinationId: args.examinationId,
      classSubjectId: args.classSubjectId,
    );

    for (final s in students) {
      final r = saved[s.studentId];
      if (r == null) continue;
      s.mcqController.text = _fmt(r['mcq_marks']);
      s.theoryController.text = _fmt(r['written_marks']);
      s.practicalController.text = _fmt(r['practical_marks']);
    }

    // আগে মার্ক না থাকলে সরাসরি এন্ট্রি মোডে খুলবে
    return MarkEntryState(students: students, isEditing: saved.isEmpty);
  }

  void _emit(MarkEntryState Function(MarkEntryState s) change) {
    if (!ref.mounted) return;
    final current = state.value;
    if (current == null) return;
    state = AsyncData(change(current));
  }

  void markChanged() => _emit((s) => s.copyWith(tick: s.tick + 1));

  void toggleEditing() => _emit((s) => s.copyWith(isEditing: !s.isEditing));

  Future<MarkSaveResult> save() async {
    final current = state.value;
    if (current == null) {
      return const MarkSaveResult.failure('ডেটা এখনও লোড হয়নি');
    }
    if (current.isSaving) {
      return const MarkSaveResult.failure('সেভ চলছে, একটু অপেক্ষা করুন');
    }

    final result = MarkService.buildRows(
      students: [
        for (final s in current.students)
          (
          studentId: s.studentId,
          roll: s.roll,
          mcq: s.mcqController.text,
          theory: s.theoryController.text,
          practical: s.practicalController.text,
          ),
      ],
      examinationId: args.examinationId,
      classSubjectId: args.classSubjectId,
    );

    if (result.hasError) {
      return MarkSaveResult.failure(result.errorMessage!);
    }

    _emit((s) => s.copyWith(isSaving: true));
    try {
      await MarkService.save(result.rows);
      _emit((s) => s.copyWith(isSaving: false, isEditing: false));
      return MarkSaveResult.success('${result.rows.length} জনের মার্ক সেভ হয়েছে');
    } catch (e) {
      _emit((s) => s.copyWith(isSaving: false));
      return MarkSaveResult.failure('সেভ করতে সমস্যা: $e');
    }
  }
}

final markEntryProvider = AsyncNotifierProvider.autoDispose
    .family<MarkEntryNotifier, MarkEntryState, MarkEntryArgs>(
  MarkEntryNotifier.new,
);