/// Teacher এর মূল তথ্য (teacher_profiles থেকে)।
class TeacherInfo {
  final String userId;
  final String? name;
  final String? designation;

  const TeacherInfo({
    required this.userId,
    this.name,
    this.designation,
  });

  factory TeacherInfo.fromJson(Map<String, dynamic> json) {
    return TeacherInfo(
      userId: json['user_id'] as String,
      name: json['full_name'] as String?,
      designation: json['designation'] as String?,
    );
  }
}