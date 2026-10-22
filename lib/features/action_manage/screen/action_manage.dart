
import 'package:flutter/material.dart';

import '../../../core/constant/app_colors.dart';
import '../widget/teacher_list.dart';

class ActionManageScreen extends StatelessWidget {
const ActionManageScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
//backgroundColor: AppColors.background,
appBar: AppBar(
title: const Text('Action Manage'),
backgroundColor: AppColors.primaryGradientStart,
foregroundColor: Colors.white,
),
body: Padding(
padding: const EdgeInsets.all(20),
child: Card(
color: AppColors.cardBackground,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(16),
side: BorderSide(color: AppColors.border),
),
child: ListTile(
contentPadding: const EdgeInsets.all(16),
leading: const CircleAvatar(
backgroundColor: Color(0xFFEFF6FF),
child: Icon(
Icons.people_alt_rounded,
color: Color(0xFF2563EB),
),
),
title: const Text(
'Teachers',
style: TextStyle(
fontWeight: FontWeight.w700,
color: AppColors.textPrimary,
),
),
subtitle: const Text('Manage teacher information'),
trailing: const Icon(Icons.arrow_forward_ios, size: 18),
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => const TeacherListScreen(),
),
);
},
),
),
),
);
}
}
