
import 'dart:typed_data';

abstract class TeacherProfileRepository {
  /// Loads teacher profile.
  Future<Map<String, dynamic>?> getProfile(String userId);

  /// Uploads teacher profile image.
  Future<String> uploadAvatar({
    required String userId,
    required Uint8List imageBytes,
  });

  /// Updates teacher profile information.
  Future<void> updateProfile({
    required String userId,
    required Map<String, dynamic> updates,
  });
}
