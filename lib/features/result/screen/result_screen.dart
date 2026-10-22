import 'package:flutter/material.dart';
//import '../../../../core/widgets/app_background.dart';
import '../../../core/widgets/app_bg.dart';
import '../../../shared/widgets/app_bar.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserAppBar(),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Result Dashboard',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome to the admin panel!',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
              // এখানে আপনার বাকি UI ডিজাইন বা উইজেটগুলো বসাতে পারবেন
            ],
          ),
        ),
      ),
// **এখানে Bottom Navigation Bar বসানো হয়েছে**
      bottomNavigationBar: BottomNavBar(),
    );
  }
}