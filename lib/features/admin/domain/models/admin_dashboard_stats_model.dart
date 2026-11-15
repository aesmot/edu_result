class AdminDashboardStatsModel {
  final int totalStudents;
  final int totalSubjects;
  final int totalResults;
  final int totalExaminations;

  AdminDashboardStatsModel({
    this.totalStudents = 0,
    this.totalSubjects = 0,
    this.totalResults = 0,
    this.totalExaminations = 0,
  });

  // সুপাবেজ থেকে ডাটা ফেচ করার পর ম্যাপ থেকে অবজেক্ট তৈরির জন্য ফ্যাক্টরি কনস্ট্রাক্টর
  factory AdminDashboardStatsModel.fromMap(Map<String, dynamic> map) {
    return AdminDashboardStatsModel(
      totalStudents: map['total_students'] ?? 0,
      totalSubjects: map['total_subjects'] ?? 0,
      totalResults: map['total_results'] ?? 0,
      totalExaminations: map['total_examinations'] ?? 0,
    );
  }
}