import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// সিলেক্টেড ক্লাস ও সাবজেক্ট আইডি
final selectedClassIdProvider = StateProvider<int?>((ref) => null);
final selectedSubjectIdProvider = StateProvider<int?>((ref) => null);
final selectedClassSubjectIdProvider = StateProvider<int?>((ref) => null); // Mark Entry/Result Filter ID

// সিলেক্টেড নাম (Result View কার্ডে সরাসরি দেখানোর জন্য)
final selectedClassNameProvider = StateProvider<String?>((ref) => null);
final selectedSubjectNameProvider = StateProvider<String?>((ref) => null);