import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/repositories/mark_entry_repository_impl.dart';
import '../../domain/repositories/mark_entry_repository.dart';
import '../controllers/mark_entry_controller.dart';

final markEntryRepositoryProvider = Provider<MarkEntryRepository>((ref) {
  return MarkEntryRepositoryImpl(Supabase.instance.client);
});

final markEntryControllerProvider =
StateNotifierProvider<MarkEntryController, AsyncValue<void>>((ref) {
  final repository = ref.watch(markEntryRepositoryProvider);
  return MarkEntryController(repository);
});