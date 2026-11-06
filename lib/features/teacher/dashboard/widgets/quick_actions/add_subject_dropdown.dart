

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../provider/teacher_class_provider.dart';

class AddSubjectDropdown extends StatelessWidget {
  const AddSubjectDropdown({
    required this.options,
    required this.enabled,
    required this.onSelected,
  });

  final List<SubjectOption> options;
  final bool enabled;
  final void Function(int classSubjectId) onSelected;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      // প্রস্থ সীমিত, তাই লম্বা নামেও overflow হবে না
      constraints: const BoxConstraints(maxWidth: 100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF2563EB)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            isDense: true,
            isExpanded: true,
            value: null,
            hint: const Text(
              '+ Subject',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2563EB),
              ),
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 18,
              color: Color(0xFF2563EB),
            ),
            items: options
                .map(
                  (s) => DropdownMenuItem<int>(
                value: s.classSubjectId,
                child: Text(
                  s.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            )
                .toList(),
            onChanged: enabled
                ? (value) {
              if (value != null) onSelected(value);
            }
                : null,
          ),
        ),
      ),
    );
  }
}