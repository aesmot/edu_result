import 'package:flutter/material.dart';

class SubjectChip extends StatelessWidget {


  final String name;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const SubjectChip({
  required this.name,
  required this.isSelected,
  required this.onTap,
  required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
  return InkWell(
  onTap: onTap,
  borderRadius: BorderRadius.circular(8),
  child: Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  decoration: BoxDecoration(
  color: isSelected ? const Color(0xFFEFF6FF) : const Color(0xFFF1F5F9),
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
  color: isSelected ? const Color(0xFF3B82F6) : Colors.grey.shade300,
  width: isSelected ? 1.2 : 0.8,
  ),
  ),
  child: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
  Text(
  name,
  style: TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: isSelected
  ? const Color(0xFF1D4ED8)
      : const Color(0xFF334155),
  ),
  ),
  if (isSelected) ...[
  const SizedBox(width: 4),
  GestureDetector(
  onTap: onDelete,
  child: const Icon(
  Icons.cancel_rounded,
  size: 16,
  color: Colors.redAccent,
  ),
  ),
  ],
  ],
  ),
  ),
  );
  }
  }