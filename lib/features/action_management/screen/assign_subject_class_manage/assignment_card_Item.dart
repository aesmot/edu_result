import 'package:flutter/material.dart';
import 'edit_assign_sub&class_screen.dart'; // আপনার এডিট পেজের সঠিক ফাইল নেম

class AssignmentCardItem extends StatelessWidget {
  final int serialNumber;
  final String teacherName;
  final String className;
  final String subjectName;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String assignmentId;

  const AssignmentCardItem({
    super.key,
    this.serialNumber = 0,
    this.teacherName = '',
    this.className = '',
    this.subjectName = '',
    this.onEdit = _emptyCallback,
    this.onDelete = _emptyCallback,
    this.assignmentId = '',
  });

  static void _emptyCallback() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1, // Border 1
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
          // 1st Column: Name (Serial + Teacher Name)
          Expanded(
            flex: 3,
            child: Row(
              children: [
                // Serial Number
                SizedBox(
                  width: 22,
                  child: Text(
                    '$serialNumber.',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),

                // Teacher Name
                Expanded(
                  child: Text(
                    teacherName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // 2nd Column: Class & Sub (Class upore, Subject niche)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Class: $className',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Sub: $subjectName',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // 3rd Column: Action Buttons (Edit & Delete)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Edit Button (Direct Navigation)
              // Edit Button
              IconButton(
                icon: const Icon(
                  Icons.edit_rounded,
                  color: Color(0xFF2563EB),
                  size: 18,
                ),
                onPressed: onEdit,
              ),
              const SizedBox(width: 4),
              // Delete Button
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