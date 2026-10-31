
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/repositories/supabase_examination_repository.dart';
import '../domain/models/examination.dart';
import '../domain/repositories/examination_repository.dart';

final examinationRepositoryProvider =
Provider<ExaminationRepository>((ref) {
  return SupabaseExaminationRepository(
    Supabase.instance.client,
  );
});

final examinationsProvider =
FutureProvider<List<Examination>>((ref) async {
  debugPrint('[ExaminationProvider] Fetch started');
  //debugPrint('[ExaminationProvider] Fetch started');

  try {
    final repository = ref.watch(examinationRepositoryProvider);

    final examinations = await repository
        .getActiveExaminations()
        .timeout(const Duration(seconds: 20));

    debugPrint(
      '[ExaminationProvider] Received ${examinations.length} examinations',
    );

    return examinations;
  } catch (error, stackTrace) {
    debugPrint('[ExaminationProvider] ERROR: $error');
    debugPrintStack(stackTrace: stackTrace);
    rethrow;
  }
});
