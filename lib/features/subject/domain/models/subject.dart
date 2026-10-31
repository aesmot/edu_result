
/// Represents a subject offered for a particular class.
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
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'].toString(),
      name: json['name'] as String,
      code: json['code'] as String?,
      classId: json['class_id'].toString(),
    );
  }

  /// Converts the subject into a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'class_id': classId,
    };
  }
}
