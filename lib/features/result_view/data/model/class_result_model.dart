class ClassResultModel {
  final String id;
  final String className;
  final int totalStudents;
  final int passed;
  final int failed;
  final double passRate;
  final String status;

  ClassResultModel({
    required this.id,
    required this.className,
    required this.totalStudents,
    required this.passed,
    required this.failed,
    required this.passRate,
    required this.status,
  });

  // Supabase থেকে আসা JSON / Map ডেটা থেকে মডেল তৈরির জন্য
  factory ClassResultModel.fromMap(Map<String, dynamic> map) {
    return ClassResultModel(
      id: map['id']?.toString() ?? '',
      className: map['class_name'] ?? '',
      totalStudents: map['total_students'] ?? 0,
      passed: map['passed'] ?? 0,
      failed: map['failed'] ?? 0,
      passRate: (map['pass_rate'] != null)
          ? (map['pass_rate'] as num).toDouble()
          : 0.0,
      status: map['status'] ?? 'Draft',
    );
  }

  factory ClassResultModel.fromJson(Map<String, dynamic> json) {
    return ClassResultModel.fromMap(json);
  }

  // ডেটাবেজে পাঠানোর প্রয়োজন হলে Map-এ রূপান্তর করার জন্য
  Map<String, dynamic> toMap() {
    return {
      'class_name': className,
      'total_students': totalStudents,
      'passed': passed,
      'failed': failed,
      'pass_rate': passRate,
      'status': status,
    };
  }

  // ডেটা কপি করার সুবিধার জন্য
  ClassResultModel copyWith({
    String? id,
    String? className,
    int? totalStudents,
    int? passed,
    int? failed,
    double? passRate,
    String? status,
  }) {
    return ClassResultModel(
      id: id ?? this.id,
      className: className ?? this.className,
      totalStudents: totalStudents ?? this.totalStudents,
      passed: passed ?? this.passed,
      failed: failed ?? this.failed,
      passRate: passRate ?? this.passRate,
      status: status ?? this.status,
    );
  }
}