
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_providers.dart';

/// Manages authentication state and session restoration.
final authControllerProvider =
AsyncNotifierProvider<AuthController, String?>(
  AuthController.new,
);

class AuthController extends AsyncNotifier<String?> {
  @override
  Future<String?> build() async {
    final repository = ref.read(authRepositoryProvider);
    return repository.restoreSession();
  }

  /// Authenticates an existing user and retrieves their role.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);

      final role = await repository.login(
        email: email.trim(),
        password: password,
      );

      return role.toLowerCase();
    });
  }

  /// Registers a new user.
  ///
  /// Does not call login() after signup.
  /// A newly registered user must wait for admin approval.
  Future<void> signup({
    required String name,
    required String identifier,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);

      await repository.signup(
        name: name.trim(),
        identifier: identifier.trim(),
        password: password,
      );

      // Signup success does not mean dashboard access.
      return null;
    });
  }

  /// Signs out the current user and clears authentication state.
  Future<void> logout() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);

      await repository.signOut();

      return null;
    });
  }
}
