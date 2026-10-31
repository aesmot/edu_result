
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasources/auth_remote_data_source.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = Supabase.instance.client;
  final dataSource = AuthRemoteDataSource(client);

  return AuthRepositoryImpl(dataSource);
});
