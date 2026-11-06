import 'package:flutter/foundation.dart';

@immutable
class StaffModel {
  final String id;
  final String? userId; // ইউজার আইডি অপশনাল করা হলো
  final String name;
  final String designation;
  final String email;
  final String phone;
  final String? imageUrl;

  const StaffModel({
    required this.id,
    this.userId,
    required this.name,
    required this.designation,
    required this.email,
    required this.phone,
    this.imageUrl,
  });

  // Supabase থেকে ডাটা পড়ার সময়
  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString(), // user_id রিড করবে
      name: json['full_name'] ?? '',
      designation: json['designation'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      imageUrl: json['avatar_url'],
    );
  }

  // Supabase-এ ডাটা পাঠানোর সময়
  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'user_id': userId, // যদি userId থাকে তবেই পাঠাবে
      'full_name': name,
      'designation': designation,
      'email': email,
      'phone': phone,
      'avatar_url': imageUrl,
    };
  }

  StaffModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? designation,
    String? email,
    String? phone,
    String? imageUrl,
  }) {
    return StaffModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}