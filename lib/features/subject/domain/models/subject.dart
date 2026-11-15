
/// Represents a subject assigned to a particular class.
class Subject {
  final String id;
  final String name;
  final String? code;
  final String classId;

  const Subject({
    required this.id,
    required this.name,
    this.code,
    required this.classId,
  });

  /// Creates a Subject instance from a Supabase row.
  factory Subject.fromJson(
      Map<String, dynamic> json, {
        String? classId,
      }) {
    return Subject(
      id: json['subject_id'].toString(),
      name: json['subject_name'] as String,
      code: json['subject_code'] as String?,
      classId: classId ?? json['class_id']?.toString() ?? '',
    );
  }

  /// Converts the subject into a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {
      'subject_id': id,
      'subject_name': name,
      'subject_code': code,
      'class_id': classId,
    };
  }
}
