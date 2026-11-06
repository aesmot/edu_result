import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClassStudent {
  final int id;
  final String roll;
  final String name;

  const ClassStudent({
    required this.id,
    required this.roll,
    required this.name,
  });

  factory ClassStudent.fromMap(Map<String, dynamic> map) {
    return ClassStudent(
      id: map['id'] as int,
      roll: map['roll'].toString(),
      name: map['name'] as String,
    );
  }
}

// classId = মাস্টার ক্লাসের id (teacherClass.classId)
final classStudentsProvider =
FutureProvider.family<List<ClassStudent>, int>((ref, classId) async {
  final rows = await Supabase.instance.client
      .from('students') // TODO: আপনার টেবিলের নাম
      .select('id, roll, name') // TODO: কলামের নাম মিলিয়ে নিন
      .eq('class_id', classId) // TODO: ক্লাসের কলামের নাম
      .order('roll', ascending: true);

  return (rows as List)
      .map((row) => ClassStudent.fromMap(row as Map<String, dynamic>))
      .toList();
});