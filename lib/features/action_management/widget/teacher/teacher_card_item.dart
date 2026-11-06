import 'package:flutter/material.dart';
import 'package:result_management_system/features/teacher/model/teacher_model.dart';

class TeacherCardItem extends StatelessWidget {
  final int serialNumber;
  final StaffModel staff;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TeacherCardItem({
    super.key,
    required this.serialNumber,
    required this.staff,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ১. বামপাশে সিরিয়াল নম্বর (স্টাইলিশ ব্যাজ ডিজাইন)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9), // হালকা গ্রে-ব্লু ব্যাকগ্রাউন্ড
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: Text(
              '$serialNumber',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF334155),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // ২. প্রোফাইল পিকচার (Avatar)
          // ২. প্রোফাইল পিকচার (Avatar)
          CircleAvatar(
            radius: 22,
            backgroundImage: (staff.imageUrl != null && staff.imageUrl!.isNotEmpty)
                ? NetworkImage(staff.imageUrl!) as ImageProvider
                : const AssetImage('assets/images/default_avatar.png'), // অথবা কোনো লোকাল এসেট বা প্লেসহোল্ডার
            backgroundColor: Colors.grey.shade200,
          ),
          const SizedBox(width: 10),

          // ৩. প্রথম কলাম: নাম এবং পদবী
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  staff.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  staff.designation,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),

          // ৪. দ্বিতীয় কলাম: মোবাইল নম্বর এবং তার নিচে ইমেইল
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // মোবাইল নম্বর (উপরে)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.phone_outlined, size: 12, color: Colors.grey.shade500),
                    const SizedBox(width: 3),
                    Text(
                      staff.phone,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // ইমেইল (মোবাইল নম্বরের ঠিক নিচে)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.email_outlined, size: 12, color: Colors.grey.shade500),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        staff.email,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),

          // ৫. এডিট এবং ডিলিট বাটন
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_rounded, color: Color(0xFF2563EB), size: 18),
                onPressed: onEdit,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(6),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 18),
                onPressed: onDelete,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}