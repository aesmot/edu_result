
import 'package:supabase_flutter/supabase_flutter.dart';

/// Handles authentication and profile queries through Supabase.
class AuthRemoteDataSource {
  AuthRemoteDataSource(this._supabase);

  final SupabaseClient _supabase;


  /// Signs up a new user and saves their profile details.
  Future<void> signUp({
    required String name,
    required String identifier,
    required String password,
  }) async {
    // 1. Supabase Auth-e user create korchi
    final response = await _supabase.auth.signUp(
      email: identifier,
      password: password,
      data: {'name': name},
    );

    final user = response.user;

    if (user == null) {
      throw Exception('Signup failed. Please try again.');
    }

    // 2. Profiles table-e user_id ebong name save korchi
    await _supabase.from('profiles').upsert({
      'user_id': user.id,
      'name': name,
    });
  }
  /// Signs in the user and retrieves their assigned role.
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );

    final user = response.user;

    if (user == null) {
      throw Exception('Login failed. Please try again.');
    }

    return _getRoleForUser(user.id);
  }

  /// Restores the role for the currently authenticated user.
  ///
  /// Returns null when no authenticated session exists.
  Future<String?> restoreSession() async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return null;
    }

    try {
      return await _getRoleForUser(user.id);
    } catch (_) {
      await _supabase.auth.signOut();
      rethrow;
    }
  }

  /// Retrieves and validates the user's assigned role.
  Future<String> _getRoleForUser(String userId) async {
    final profile = await _supabase
        .from('profiles')
        .select('role')
        .eq('user_id', userId)
        .maybeSingle();

    final role = (profile?['role'] as String?)?.toLowerCase();

    if (role != 'admin' && role != 'teacher') {
      throw Exception('No valid role assigned to this account.');
    }

    return role!;
  }

  /// Signs out the currently authenticated user.
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
