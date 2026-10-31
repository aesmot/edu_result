class Examination {
  final String id;
  final String name;
  final int academicYear;

  const Examination({
    required this.id,
    required this.name,
    required this.academicYear,
  });

  factory Examination.fromJson(Map<String, dynamic> json) {
    return Examination(
      id: json['id'] as String,
      name: json['name'] as String,
      academicYear: (json['academic_year'] as num).toInt(),
    );
  }
}