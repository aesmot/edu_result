import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_bar.dart';
import '../../../examination/domain/models/examination_model.dart';
import '../../../examination/widgets/examination_dropdown.dart';
import '../widgets/dashboard_quick_actions.dart';
import '../widgets/recent_activity_section.dart';
import 'profile_screen.dart'; // ProfileScreen এর আসল path অনুযায়ী মিলিয়ে নিন

class TeacherDashboardScreen extends StatefulWidget {

  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() =>
      _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  ExaminationModel? selectedExam; // এটি ড্যাশবোর্ড স্টেটে থাকবে
  String? selectedExaminationId;


  // বর্তমানে কোন ট্যাব সক্রিয়: 0 = Home, 1 = Result, 2 = Profile
  int _currentIndex = 0;

  Widget _buildHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const Text(
            'Teacher Dashboard Overview',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          ExaminationDropdown(
            selectedExaminationId: selectedExam?.id,
            onChanged: (examination) {
              setState(() {
                selectedExam = examination; // এখানে সিলেক্ট করা এক্সাম সেট হলো
              });
            },
          ),


          const SizedBox(height: 16),
           DashboardQuickActions(selectedExam: selectedExam,),
          const SizedBox(height: 24),
           RecentActivitySection(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserAppBar(),

      // IndexedStack: ট্যাব বদলালেও আগের ট্যাবের অবস্থা ধরে রাখে
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHome(),
          const Center(child: Text('Result (শীঘ্রই আসছে)')), // পরে আসল স্ক্রিন বসান
          const ProfileScreen(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Result',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}