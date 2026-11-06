
/// Defines the authentication operations required by the app.
abstract interface class AuthRepository {
  Future<String> login({
    required String email,
    required String password,
  });

  Future<void> signup({
    required String name,
    required String identifier,
    required String password,
  });

  Future<String?> restoreSession();

  Future<void> signOut();
}