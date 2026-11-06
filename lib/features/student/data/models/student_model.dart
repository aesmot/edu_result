class StudentModel {
  final int id;
  final String rollNumber;
  final String name;
  final int classId;
  final bool isActive;

  StudentModel({
    required this.id,
    required this.rollNumber,
    required this.name,
    required this.classId,
    required this.isActive,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['student_id'] as int,
      rollNumber: json['roll_number'] as String,
      name: json['student_name'] as String,
      classId: json['class_id'] as int,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': id,
      'roll_number': rollNumber,
      'student_name': name,
      'class_id': classId,
      'is_active': isActive,
    };
  }
}