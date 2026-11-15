import 'package:flutter/material.dart';

import 'mark_input_field.dart';

/// Displays one student's identity and marks for each exam component.
class StudentMarkRow extends StatelessWidget {
  const StudentMarkRow({
    super.key,
    required this.roll,
    required this.name,
    required this.mcqController,
    required this.theoryController,
    required this.practicalController,
    required this.onMcqChanged,
    required this.onTheoryChanged,
    required this.onPracticalChanged,
    required this.total,
    this.mcqMax = 25,
    this.theoryMax = 50,
    this.practicalMax = 25,
    this.enabled = true,
    this.isEditing = true,
  });

  final String roll;
  final String name;

  final TextEditingController mcqController;
  final TextEditingController theoryController;
  final TextEditingController practicalController;

  final ValueChanged<String> onMcqChanged;
  final ValueChanged<String> onTheoryChanged;
  final ValueChanged<String> onPracticalChanged;

  final int? total;

  final int mcqMax;
  final int theoryMax;
  final int practicalMax;
  final bool enabled;

  /// true hole input field, false hole shudhu text dekhabe.
  final bool isEditing;

  Widget _markCell({
    required TextEditingController controller,
    required int maxMark,
    required ValueChanged<String> onChanged,
  }) {
    return SizedBox(
      width: 58,
      child: isEditing
          ? MarkInputField(
        controller: controller,
        maxMark: maxMark,
        onChanged: onChanged,
        enabled: enabled,
        width: 58,
      )
          : Text(
        controller.text.trim().isEmpty ? '—' : controller.text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          // Roll
          SizedBox(
            width: 42,
            child: Text(
              roll,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),

          // Student Name
          SizedBox(
            width: 160,
            child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // MCQ
          _markCell(
            controller: mcqController,
            maxMark: mcqMax,
            onChanged: onMcqChanged,
          ),

          const SizedBox(width: 6),

          // Theory
          _markCell(
            controller: theoryController,
            maxMark: theoryMax,
            onChanged: onTheoryChanged,
          ),

          const SizedBox(width: 6),

          // Practical
          _markCell(
            controller: practicalController,
            maxMark: practicalMax,
            onChanged: onPracticalChanged,
          ),

          const SizedBox(width: 20),

          // Total
          SizedBox(
            width: 42,
            child: Text(
              total?.toString() ?? '—',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C6FE5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}