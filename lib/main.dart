import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/authentication/presentation/screens/auth_gate_screen.dart';




void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Supabase.initialize(
      url: 'https://mkjmvjdhjqzfuvrdciuu.supabase.co',
      publishableKey: 'sb_publishable_MiZaw9UKS72MtW90pYykqg_DeHxAE0Y',
    );
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
        home: const AuthGateScreen()
    );
  }
}
