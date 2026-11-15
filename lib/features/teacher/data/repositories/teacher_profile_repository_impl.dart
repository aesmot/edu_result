
import 'dart:typed_data';

import '../../domain/repositories/teacher_profile_repository.dart';
import '../datasources/teacher_profile_remote_data_source.dart';

class TeacherProfileRepositoryImpl
    implements TeacherProfileRepository {
  TeacherProfileRepositoryImpl(this._dataSource);

  final TeacherProfileRemoteDataSource _dataSource;

  @override
  Future<Map<String, dynamic>?> getProfile(String userId) {
    return _dataSource.getProfile(userId);
  }

  @override
  Future<String> uploadAvatar({
    required String userId,
    required Uint8List imageBytes,
  }) {
    return _dataSource.uploadAvatar(
      userId: userId,
      imageBytes: imageBytes,
    );
  }

  @override
  Future<void> updateProfile({
    required String userId,
    required Map<String, dynamic> updates,
  }) {
    return _dataSource.updateProfile(
      userId: userId,
      updates: updates,
    );
  }
}
