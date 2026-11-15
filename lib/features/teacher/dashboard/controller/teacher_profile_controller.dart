
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../provider/teacher_profile_provider.dart';


/// Holds teacher profile screen state.
class TeacherProfileState {
  const TeacherProfileState({
    this.profile,
    this.pickedImage,
    this.isLoading = false,
    this.isSaving = false,
  });

  final Map<String, dynamic>? profile;
  final Uint8List? pickedImage;
  final bool isLoading;
  final bool isSaving;

  TeacherProfileState copyWith({
    Map<String, dynamic>? profile,
    Uint8List? pickedImage,
    bool clearPickedImage = false,
    bool? isLoading,
    bool? isSaving,
  }) {
    return TeacherProfileState(
      profile: profile ?? this.profile,
      pickedImage:
      clearPickedImage ? null : pickedImage ?? this.pickedImage,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

/// Manages teacher profile operations.
class TeacherProfileController extends Notifier<TeacherProfileState> {
  @override
  TeacherProfileState build() {
    return const TeacherProfileState();
  }

  final _imagePicker = ImagePicker();

  /// Loads logged-in teacher profile.
  Future<void> loadProfile() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      throw Exception('লগইন করা নেই');
    }

    state = state.copyWith(isLoading: true);

    try {
      final profile = await ref
          .read(teacherProfileRepositoryProvider)
          .getProfile(user.id);

      state = state.copyWith(
        profile: profile,
        isLoading: false,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  /// Picks profile image from gallery.
  Future<void> pickImage() async {
    final picked = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 800,
    );

    if (picked == null) return;

    final imageBytes = await picked.readAsBytes();

    state = state.copyWith(pickedImage: imageBytes);
  }

  /// Saves teacher profile information.
  Future<void> saveProfile({
    required String designation,
    required String phone,
  }) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      throw Exception('লগইন করা নেই');
    }

    final updates = <String, dynamic>{
      if (designation.trim().isNotEmpty)
        'designation': designation.trim(),
      if (phone.trim().isNotEmpty)
        'phone': phone.trim(),
    };

    if (state.pickedImage == null && updates.isEmpty) {
      throw Exception('কোনো পরিবর্তন করা হয়নি');
    }

    state = state.copyWith(isSaving: true);

    try {
      // Upload selected image.
      if (state.pickedImage != null) {
        final imageUrl = await ref
            .read(teacherProfileRepositoryProvider)
            .uploadAvatar(
          userId: user.id,
          imageBytes: state.pickedImage!,
        );

        updates['avatar_url'] = imageUrl;
      }

      // Update profile in database.
      if (updates.isNotEmpty) {
        await ref
            .read(teacherProfileRepositoryProvider)
            .updateProfile(
          userId: user.id,
          updates: updates,
        );
      }

      final updatedProfile = {
        ...?state.profile,
        ...updates,
      };

      state = state.copyWith(
        profile: updatedProfile,
        clearPickedImage: true,
        isSaving: false,
      );
    } catch (_) {
      state = state.copyWith(isSaving: false);
      rethrow;
    }
  }
}

/// Provides teacher profile controller.
final teacherProfileControllerProvider =
NotifierProvider<TeacherProfileController, TeacherProfileState>(
  TeacherProfileController.new,
);
