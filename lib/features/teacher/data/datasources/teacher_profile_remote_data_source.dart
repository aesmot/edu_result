
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

/// Handles teacher profile operations with Supabase.
class TeacherProfileRemoteDataSource {
  TeacherProfileRemoteDataSource(this._supabase);

  final SupabaseClient _supabase;

  /// Loads the logged-in teacher's profile.
  Future<Map<String, dynamic>?> getProfile(String userId) async {
    return await _supabase
        .from('teacher_profiles')
        .select('full_name, email, designation, phone, avatar_url')
        .eq('user_id', userId)
        .maybeSingle();
  }

  /// Uploads teacher profile image to Supabase Storage.
  Future<String> uploadAvatar({
    required String userId,
    required Uint8List imageBytes,
  }) async {
    final fileName =
        '$userId/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';

    await _supabase.storage.from('avatars').uploadBinary(
      fileName,
      imageBytes,
      fileOptions: const FileOptions(
        contentType: 'image/jpeg',
      ),
    );

    return _supabase.storage
        .from('avatars')
        .getPublicUrl(fileName);
  }

  /// Updates teacher profile information.
  Future<void> updateProfile({
    required String userId,
    required Map<String, dynamic> updates,
  }) async {
    await _supabase
        .from('teacher_profiles')
        .update(updates)
        .eq('user_id', userId);
  }
}
