
import '../models/examination_model.dart';

abstract class ExaminationRepository {
  Future<List<ExaminationModel>> getActiveExaminations();
}
