

import 'package:flutter/material.dart';

class SubjectChip extends StatelessWidget {

  const SubjectChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.onRemove,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : Colors.black87;

    return Container(
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF2563EB) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: selected ? const Color(0xFF2563EB) : Colors.grey.shade400,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 6, bottom: 2),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onRemove,
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: Icon(Icons.close, size: 14, color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}