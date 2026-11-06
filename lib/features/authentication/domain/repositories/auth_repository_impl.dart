import '../../data/datasources/auth_remote_data_source.dart';
import 'auth_repository.dart';

/// Implements the authentication contract using the data source.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final AuthRemoteDataSource _dataSource;

  // 1. Add the missing login method here
  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    return await _dataSource.signIn(
      email: email.trim(),
      password: password,
    );
  }

  @override
  Future<void> signup({
    required String name,
    required String identifier,
    required String password,
  }) async {
    return await _dataSource.signUp(
      name: name.trim(),
      identifier: identifier.trim(),
      password: password,
    );
  }

  @override
  Future<String?> restoreSession() {
    return _dataSource.restoreSession();
  }

  @override
  Future<void> signOut() {
    return _dataSource.signOut();
  }
}