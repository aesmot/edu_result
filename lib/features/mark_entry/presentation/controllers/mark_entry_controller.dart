import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/student_mark.dart';
import '../../domain/repositories/mark_entry_repository.dart';
import 'student_marks_ui.dart';

class MarkEntryController extends StateNotifier<AsyncValue<void>> {
  final MarkEntryRepository _repository;

  MarkEntryController(this._repository) : super(const AsyncValue.data(null));

  Future<bool> saveAllMarks({
    required List<StudentMarksUI> studentsUiList,
    required int classSubjectId,
    required String examinationId,
  }) async {
    state = const AsyncValue.loading();
    try {
      final List<StudentMark> marksToSave = studentsUiList.map((ui) {
        return StudentMark(
          studentId: ui.studentId,
          classSubjectId: classSubjectId,
          examinationId: examinationId,
          mcqMarks: double.tryParse(ui.mcqController.text) ?? 0.0,
          writtenMarks: double.tryParse(ui.theoryController.text) ?? 0.0,
          practicalMarks: double.tryParse(ui.practicalController.text) ?? 0.0,
        );
      }).toList();

      await _repository.saveStudentMarks(marksToSave);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}