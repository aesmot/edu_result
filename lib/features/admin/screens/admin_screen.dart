import 'package:flutter/material.dart';
import 'package:result_management_system/features/admin/screens/admin_screen_statusCard.dart';
import 'package:result_management_system/features/admin/screens/recent_acitivity_list.dart';
import 'package:result_management_system/features/admin/screens/widget/admin_quick_action_list.dart';
import '../../../core/widgets/app_bg.dart';
import '../../../shared/widgets/app_bar.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';
import '../../../shared/widgets/sectionTitle/icon_section_title.dart';
import '../../result_view/presentation/widgets/exam_performance_card.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // ব্যাকগ্রাউন্ডে একটি সফট প্রফেশনাল শেড দেওয়া হলো
      appBar: const UserAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          // প্যাডিং চারপাশ থেকে একটু বাড়িয়ে ২০ করা হলো, যাতে স্ক্রিনের কোণায় লেগে না থাকে
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // টেক্সটগুলো সুন্দরভাবে বাম দিক থেকে শুরু হবে
            children: [
              // Welcome / Subtitle Header

              const IconSectionTitle(
                title: 'Admin Dashboard',
                icon: Icons.grid_view_rounded,
              ),
              const SizedBox(height: 16), // স্ট্যাটাস কার্ডের আগে উপযুক্ত স্পেস

              // Status Grid Card
              const AdminDashboardStatusGrid(),

              const SizedBox(height: 24), // সেকশন পরিবর্তনের জন্য স্ট্যান্ডার্ড গ্যাপ (২৪ পিক্সেল)

              // Quick Actions Section
              const IconSectionTitle(
                title: 'Recent Activities',
                icon: Icons.grid_view_rounded,
              ),
              const AdminQuickActionsSection(),

              const SizedBox(height: 28), // সেকশন গ্যাপ

              // Section Title: Recent Activities
              //'',
              // ১. কুইক অ্যাকশন হেডারের জন্য (Icon-based):
              const IconSectionTitle(
                title: 'Recent Activities',
                icon: Icons.grid_view_rounded,
              ),



              const SizedBox(height: 14), // টাইটেল এবং লিস্টের মাঝখানে স্ট্যান্ডার্ড গ্যাপ

              // Recent Activities List
              const RecentActivitiesList(),

              // একদম নিচে স্ক্রোল করার পর যেন বটম নেভবারের নিচে কন্টেন্ট ঢেকে না যায়, তাই এক্সট্রা স্পেস
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}