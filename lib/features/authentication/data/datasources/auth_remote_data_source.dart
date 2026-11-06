
import 'package:supabase_flutter/supabase_flutter.dart';

/// Handles authentication and profile queries through Supabase.
class AuthRemoteDataSource {
  AuthRemoteDataSource(this._supabase);

  final SupabaseClient _supabase;

  /// Signs up a new user using either email or mobile number.
  Future<void> signUp({
    required String name,
    required String identifier,
    required String password,
  }) async {
    final value = identifier.trim();
    final isEmail = value.contains('@');

    // Normalize Bangladeshi mobile numbers to E.164 format.
    final phone = isEmail ? null : _normalizeBdPhone(value);

    // Create Supabase Auth account.
    final response = await _supabase.auth.signUp(
      email: isEmail ? value.toLowerCase() : null,
      phone: phone,
      password: password,
      data: {
        'name': name.trim(),
      },
    );

    final user = response.user;

    if (user == null) {
      throw Exception('Signup failed. Please try again.');
    }

    // Create the user profile with pending approval.
    await _supabase.from('profiles').upsert({
      'user_id': user.id,
      'role': 'teacher',
      'approval_status': 'pending',
    });

    //new teacher add code
    await _supabase.from('teacher_profiles').insert({
      'user_id': user.id,
      'full_name': name.trim(),
      'email': isEmail ? value.toLowerCase() : '',
      'phone': phone ?? '',
    });
  }

  /// Converts Bangladeshi mobile numbers to E.164 format.
  String _normalizeBdPhone(String value) {
    final cleaned = value.replaceAll(RegExp(r'[\s-]'), '');

    if (RegExp(r'^\+8801[3-9]\d{8}$').hasMatch(cleaned)) {
      return cleaned;
    }

    if (RegExp(r'^01[3-9]\d{8}$').hasMatch(cleaned)) {
      return '+88${cleaned}';
    }

    if (RegExp(r'^8801[3-9]\d{8}$').hasMatch(cleaned)) {
      return '+$cleaned';
    }

    throw Exception(
      'Please enter a valid Bangladeshi mobile number.',
    );
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
