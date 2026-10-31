
import '../models/examination.dart';

abstract class ExaminationRepository {
  Future<List<Examination>> getActiveExaminations();
}
