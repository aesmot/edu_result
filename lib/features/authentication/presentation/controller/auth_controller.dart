
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
// Restore the existing session when the app starts.
final repository = ref.read(authRepositoryProvider);
return repository.restoreSession();
}

/// Authenticates a user and stores the assigned role.
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