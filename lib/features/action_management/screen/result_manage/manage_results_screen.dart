import 'package:flutter/material.dart';
import 'package:result_management_system/features/action_management/screen/result_manage/widget/result_card.dart';
import 'package:result_management_system/shared/widgets/app_bar.dart';

class ManageResultsScreen extends StatefulWidget {
  const ManageResultsScreen({super.key});

  @override
  State<ManageResultsScreen> createState() => _ManageResultsScreenState();
}

class _ManageResultsScreenState extends State<ManageResultsScreen> {
  // Dropdown Selected Values
  String selectedExam = 'Annual 2026';
  String selectedClass = 'Class 9';

  // Dropdown Options
  final List<String> examList = ['Annual 2026', 'Mid Term 2026', 'First Term 2026'];
  final List<String> classList = ['Class 6', 'Class 7', 'Class 8', 'Class 9', 'Class 10'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFF8FAFC),
      appBar: UserAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Select Filters Row (Exam & Class)
            Row(
              children: [
                Expanded(
                  child: _buildDropdownField(
                    label: 'Select Exam',
                    value: selectedExam,
                    items: examList,
                    onChanged: (val) {
                      if (val != null) setState(() => selectedExam = val);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDropdownField(
                    label: 'Select Class',
                    value: selectedClass,
                    items: classList,
                    onChanged: (val) {
                      if (val != null) setState(() => selectedClass = val);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 2. Result Overview Section Title
            const Text(
              'Result Overview',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),

            // Result Overview Stats Cards Grid (Reusable Component)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: const [
                ResultStatCard(title: 'Total Students', value: '120'),
                ResultStatCard(title: 'Marks Entered', value: '85%'),
                ResultStatCard(title: 'Pending', value: '18'),
                ResultStatCard(title: 'Approved', value: '0'),
              ],
            ),

            const SizedBox(height: 24),

            // 3. Management Actions Section Title
            const Text(
              'Management Actions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),

            // Management Action Cards List (Reusable Component)
            ResultActionCard(
              icon: Icons.assignment_turned_in_outlined,
              iconBgColor: const Color(0xFFFEF2F2),
              iconColor: const Color(0xFFEF4444),
              title: 'Result Approval',
              subtitle: 'Review and approve final results',
              onTap: () {
                // TODO: Navigate to Result Approval Screen
              },
            ),
            ResultActionCard(
              icon: Icons.calculate_outlined,
              iconBgColor: const Color(0xFFF3E8FF),
              iconColor: const Color(0xFFA855F7),
              title: 'Grade Setup',
              subtitle: 'Manage grading rules',
              onTap: () {
                // TODO: Navigate to Grade Setup Screen
              },
            ),
            ResultActionCard(
              icon: Icons.bar_chart_rounded,
              iconBgColor: const Color(0xFFECFDF5),
              iconColor: const Color(0xFF10B981),
              title: 'Result Summary',
              subtitle: 'View result statistics',
              onTap: () {
                // TODO: Navigate to Result Summary Screen
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for Dropdowns
  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B)),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0F172A),
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}