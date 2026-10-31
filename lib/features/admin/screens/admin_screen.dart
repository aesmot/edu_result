import 'package:flutter/material.dart';
import 'package:result_management_system/features/admin/screens/admin_screen_statusCard.dart';
import 'package:result_management_system/features/admin/screens/recent_acitivity_list.dart';
import 'package:result_management_system/features/admin/screens/widget/admin_quick_action_list.dart';
//import '../../../../core/widgets/app_background.dart';
import '../../../core/widgets/app_bg.dart';
import '../../../shared/widgets/app_bar.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';
import '../../result_view/presentation/widgets/exam_performance_card.dart';
//import '../../action_manage/screen/action_manage_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserAppBar(),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            
            
                Text(
                  'Admin Dashboard. ',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                //my 4AdminDashboardStatusGridedBox(height: 10),
                ExamPerformanceCard(
                  examName: 'Half Yearly Examination',
                  academicYear: '2026',
                  className: '6',
                  subjectName: 'ICT / Science',
                ),
                AdminDashboardStatusGrid(), // Ekhane call kore dilei design chole ashbe
            
                // এখানে আপনার বাকি UI ডিজাইন বা উইজেটগুলো বসাতে পারবেন
                SizedBox(height: 10),
                AdminQuickActionsSection(),
                SizedBox(height: 10),
                Text(
                  'Recent Activities',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                //ActionManageScreen(),
                //SizedBox(height: 12),
                RecentActivitiesList(),
              ],
            ),
          ),
        ),
      ),
// **এখানে Bottom Navigation Bar বসানো হয়েছে**
      bottomNavigationBar: BottomNavBar(),
    );
  }
}