
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/services/mark_calculator.dart';
import '../../domain/services/mark_validator.dart';

/// Stores and manages marks entered for each student.
class MarkEntryState {
  const MarkEntryState({
    this.marks = const {},
    this.errors = const {},
  });

  /// Student roll -> component name -> entered mark.
  final Map<String, Map<String, int?>> marks;

  /// Student roll -> component name -> validation error.
  final Map<String, Map<String, String>> errors;

  MarkEntryState copyWith({
    Map<String, Map<String, int?>>? marks,
    Map<String, Map<String, String>>? errors,
  }) {
    return MarkEntryState(
      marks: marks ?? this.marks,
      errors: errors ?? this.errors,
    );
  }
}

/// Manages mark entry, validation, and total calculation.
class MarkEntryController extends Notifier<MarkEntryState> {
  final MarkCalculator _calculator = const MarkCalculator();
  final MarkValidator _validator = const MarkValidator();

  @override
  MarkEntryState build() => const MarkEntryState();

  /// Updates one component mark and validates the student's entry.
  void updateMark({
    required String studentRoll,
    required String component,
    required String value,
    required int maxMark,
  }) {
    final parsedMark = value.trim().isEmpty
        ? null
        : int.tryParse(value.trim());

    final updatedMarks = Map<String, Map<String, int?>>.from(
      state.marks,
    );

    updatedMarks[studentRoll] = {
      ...?state.marks[studentRoll],
      component: parsedMark,
    };

    final updatedErrors = Map<String, Map<String, String>>.from(
      state.errors,
    );

    final studentErrors = Map<String, String>.from(
      state.errors[studentRoll] ?? {},
    );

    final error = _validator.validateMark(
      mark: parsedMark,
      maxMark: maxMark,
      componentName: component.toUpperCase(),
    );

    if (error == null) {
      studentErrors.remove(component);
    } else {
      studentErrors[component] = error;
    }

    if (studentErrors.isEmpty) {
      updatedErrors.remove(studentRoll);
    } else {
      updatedErrors[studentRoll] = studentErrors;
    }

    state = state.copyWith(
      marks: updatedMarks,
      errors: updatedErrors,
    );
  }

  /// Returns the total for a student when all components are entered.
  /// Returns null if any component is missing or invalid.
  int? calculateStudentTotal({
    required String studentRoll,
    required int mcqMax,
    required int thMax,
    required int prMax,
  }) {
    final studentMarks = state.marks[studentRoll];

    if (studentMarks == null) return null;

    final mcq = studentMarks['mcq'];
    final th = studentMarks['th'];
    final pr = studentMarks['pr'];

    if (mcq == null || th == null || pr == null) return null;

    final errors = _validator.validateMarks(
      mcq: mcq,
      th: th,
      pr: pr,
      mcqMax: mcqMax,
      thMax: thMax,
      prMax: prMax,
    );

    if (errors.isNotEmpty) return null;

    return _calculator.calculateTotal(
      mcq: mcq,
      th: th,
      pr: pr,
    );
  }

  /// Clears the current mark-entry state.
  void resetState() {
    state = const MarkEntryState();
  }
}

/// Riverpod provider for the mark-entry controller.
final markEntryControllerProvider =
NotifierProvider<MarkEntryController, MarkEntryState>(
  MarkEntryController.new,
);
