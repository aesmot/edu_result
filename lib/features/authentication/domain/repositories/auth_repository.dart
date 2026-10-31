
/// Defines the authentication operations required by the app.
abstract interface class AuthRepository {
  /// Signs in a user and returns their assigned role.
  Future<String> login({
    required String email,
    required String password,
  });

  /// Restores the role of the currently authenticated user.
  ///
  /// Returns null when no active session exists.
  Future<String?> restoreSession();

  /// Signs out the currently authenticated user.
  Future<void> signOut();
}
