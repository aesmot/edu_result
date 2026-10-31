
/// Handles pure mark calculation logic independently of the UI.
///
/// Keeping calculations in a separate class makes them easier to test
/// and reuse across mark entry and result generation.
class MarkCalculator {
  const MarkCalculator();

  /// Calculates the total marks obtained by a student.
  int calculateTotal({
    required int mcq,
    required int th,
    required int pr,
  }) {
    return mcq + th + pr;
  }
}
