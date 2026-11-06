class StudentMark {
  final int? markId;
  final int studentId;
  final int classSubjectId;
  final String examinationId;
  final double mcqMarks;
  final double writtenMarks;
  final double practicalMarks;
  final String? createdBy;

  StudentMark({
    this.markId,
    required this.studentId,
    required this.classSubjectId,
    required this.examinationId,
    required this.mcqMarks,
    required this.writtenMarks,
    required this.practicalMarks,
    this.createdBy,
  });

  // Total marks computed dynamically
  double get totalMarks => mcqMarks + writtenMarks + practicalMarks;

  factory StudentMark.fromJson(Map<String, dynamic> json) {
    return StudentMark(
      markId: json['mark_id'] as int?,
      studentId: json['student_id'] as int,
      classSubjectId: json['class_subject_id'] as int,
      examinationId: json['examination_id'] as String,
      mcqMarks: (json['mcq_marks'] as num?)?.toDouble() ?? 0.0,
      writtenMarks: (json['written_marks'] as num?)?.toDouble() ?? 0.0,
      practicalMarks: (json['practical_marks'] as num?)?.toDouble() ?? 0.0,
      createdBy: json['created_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (markId != null) 'mark_id': markId,
      'student_id': studentId,
      'class_subject_id': classSubjectId,
      'examination_id': examinationId,
      'mcq_marks': mcqMarks,
      'written_marks': writtenMarks,
      'practical_marks': practicalMarks,
      if (createdBy != null) 'created_by': createdBy,
    };
  }
}