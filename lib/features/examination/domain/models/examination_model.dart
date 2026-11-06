class ExaminationModel {
  final String id;
  final String name;
  final int academicYear;

  const ExaminationModel({
    required this.id,
    required this.name,
    required this.academicYear,
  });

  factory ExaminationModel.fromJson(Map<String, dynamic> json) {
    return ExaminationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      academicYear: (json['academic_year'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'academic_year': academicYear,
    };
  }
}