import 'package:flutter/material.dart';
import 'package:result_management_system/features/authentication/presentation/screens/signup_screen.dart';
import 'package:result_management_system/features/authentication/splash/splash_screen.dart';
import 'package:result_management_system/features/result/screen/result_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/widgets/curved_background.dart';
import 'features/action_manage/screen/action_manage.dart';
import 'features/admin/screens/admin_screen.dart';
import 'features/authentication/presentation/screens/login_screen.dart';
import 'features/teacher/screens/teacher_screen.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Supabase.initialize(
      url: 'YOUR_SUPABASE_URL',
      anonKey: 'YOUR_SUPABASE_ANON_KEY',
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),

      home: const LoginScreen(),
     // home: const SignUpScreen(),
      //home: const AdminScreen(),
      //home: TeacherListScreen(),
      //home: const ResultScreen(),
      //home: const ActionManageScreen(),
    );
  }
}
