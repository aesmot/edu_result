import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_bar.dart';
import '../widgets/ClassListScreen.dart';

class ClassWiseMarkManagementScreen extends StatelessWidget {
  const ClassWiseMarkManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Note: index fix kora hoyeche (10 - index -> 10 theke 1 porjonto)
    // final classes = List.generate(10, (index) => 10 - index);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB), // Background clean soft tint
      appBar: UserAppBar(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100), // Responsive max width
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24), // Proper padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ClassListScreen(),
                  // Otiirikto text soriye dewa holo, proyojon hole ekhane aro widget add korte parben
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}