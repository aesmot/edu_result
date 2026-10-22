
import 'package:flutter/material.dart';
import '../../../core/constant/app_colors.dart';

class TeacherListScreen extends StatelessWidget {
const TeacherListScreen({super.key});

@override
Widget build(BuildContext context) {
final teachers = [
{
'name': 'Abdullah Rahman',
  'designation': 'Assistant Proffsor',  'subject': 'Mathematics',
'email': 'abdullah@example.com', 'Mobile Number': '78687686',
},
  {
    'name': 'Abdullah Rahman',
    'designation': 'Assistant Proffsor',  'subject': 'Mathematics',
    'email': 'abdullah@example.com', 'Mobile Number': '78687686',
  },{
    'name': 'Abdullah Rahman',
    'designation': 'Assistant Proffsor',  'subject': 'Mathematics',
    'email': 'abdullah@example.com', 'Mobile Number': '78687686',
  },
];

return Scaffold(
//backgroundColor: AppColors.background,
appBar: AppBar(
title: const Text('Teacher List'),
backgroundColor: AppColors.primaryGradientStart,
foregroundColor: Colors.white,
elevation: 0,
),
body: Padding(
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'All Teachers',
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
color: AppColors.textPrimary,
),
),
const SizedBox(height: 6),
const Text(
'Manage teacher information',
style: TextStyle(
fontSize: 14,
color: AppColors.textMuted,
),
),
const SizedBox(height: 20),

Expanded(
  child: ListView.separated(
itemCount: teachers.length,
separatorBuilder: (_, __) =>
const SizedBox(height: 2),
itemBuilder: (context, index) {
final teacher = teachers[index];

return Container(
padding: const EdgeInsets.all(8),
decoration: BoxDecoration(
color: AppColors.cardBackground,
borderRadius: BorderRadius.circular(16),
border: Border.all(
color: AppColors.border,
),
),
child: Row(
children: [
const CircleAvatar(
radius: 20,
backgroundColor: Color(0xFFE0F2FE),
child: Icon(
Icons.person_rounded,
color: Color(0xFF0284C7),
size: 28,
),
),
const SizedBox(width: 14),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

      Text(
      teacher['name']!,
      style: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
      ),
      ),
      const SizedBox(height: 5),

      Row(
        children: [
          Text(
          teacher['designation']!,
          style: const TextStyle(
          fontSize: 13,
          color: AppColors.textMuted,
          ),
          ),
SizedBox(width: 20,),
          Text(
            teacher['subject']!,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
      const SizedBox(height: 3),

      Row(
        children: [
          Text(
          teacher['email']!,
          style: const TextStyle(
          fontSize: 12,
          color: AppColors.textMuted,
          ),

          ), SizedBox(width: 8),
          Text(
            teacher['Mobile Number']!,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
],
),
),

const SizedBox(width: 8),

// Design only: Edit and Delete options
Row(
  children: [
    IconButton(
    onPressed: null,
    tooltip: 'Edit',
    icon: Icon(
    Icons.edit_outlined,
    color: Color(0xFF2563EB),
    ),
    ),
    IconButton(
    onPressed: null,
    tooltip: 'Delete',
    icon: Icon(
    Icons.delete_outline_rounded,
    color: Color(0xFFDC2626),
    ),
    ),
  ],
),
],
),
);
},
),
),
],
),
),
);
}
}