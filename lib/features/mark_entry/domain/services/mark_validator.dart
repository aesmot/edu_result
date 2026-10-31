
/// Validates student marks against the allowed marks for each component.
///
/// This class contains no UI or database dependencies, so its validation
/// rules can be tested independently.
class MarkValidator {
  const MarkValidator();

  /// Validates a single mark component.
  ///
  /// Returns an error message if the mark is invalid;
  /// otherwise, returns null.
  String? validateMark({
    required int? mark,
    required int maxMark,
    required String componentName,
  }) {
    if (mark == null) {
      return '$componentName mark must be a valid number.';
    }

    if (maxMark < 0) {
      return 'Maximum marks cannot be negative.';
    }

    if (mark < 0) {
      return '$componentName mark cannot be negative.';
    }

    if (mark > maxMark) {
      return '$componentName mark cannot exceed $maxMark.';
    }

    return null;
  }

  /// Validates MCQ, theory, and practical marks.
  ///
  /// The maximum marks are supplied by the caller so that this
  /// validator can support different subject mark distributions.
  Map<String, String> validateMarks({
    required int? mcq,
    required int? th,
    required int? pr,
    required int mcqMax,
    required int thMax,
    required int prMax,
  }) {
    final errors = <String, String>{};

    final mcqError = validateMark(
      mark: mcq,
      maxMark: mcqMax,
      componentName: 'MCQ',
    );
    if (mcqError != null) errors['mcq'] = mcqError;

    final thError = validateMark(
      mark: th,
      maxMark: thMax,
      componentName: 'Theory',
    );
    if (thError != null) errors['th'] = thError;

    final prError = validateMark(
      mark: pr,
      maxMark: prMax,
      componentName: 'Practical',
    );
    if (prError != null) errors['pr'] = prError;

    return errors;
  }
}
