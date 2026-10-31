
import 'package:flutter/material.dart';

class ResultApproveCard extends StatelessWidget {
  const ResultApproveCard({
    super.key,
    required this.resultData,
  });

  final List<Map<String, dynamic>> resultData;

  @override
  Widget build(BuildContext context) {
    if (resultData.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('No result available'),
        ),
      );
    }

    return Column(
      children: resultData.map((student) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _StudentResultCard(student: student),
        );
      }).toList(),
    );
  }
}

class _StudentResultCard extends StatelessWidget {
  const _StudentResultCard({
    required this.student,
  });

  final Map<String, dynamic> student;

  @override
  Widget build(BuildContext context) {
    final status = student['status'].toString();
    final isPending = status == 'Pending';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Student identity
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFEFF6FF),
                child: Text(
                  student['roll'].toString(),
                  style: const TextStyle(
                    color: Color(0xFF2563EB),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student['studentId'].toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Roll: ${student['roll']}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              _StatusBadge(status: status),
            ],
          ),

          const Divider(height: 24),

          // Result information
          Row(
            children: [
              Expanded(
                child: _InfoItem(
                  label: 'Total Marks',
                  value: student['totalMark'].toString(),
                ),
              ),
              Expanded(
                child: _InfoItem(
                  label: 'GPA',
                  value: student['gpa'].toString(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Action buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (!isPending)
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Review'),
                ),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A34A),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Approve'),
              ),

              if (isPending)
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDC2626),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Reject'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final isPending = status == 'Pending';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: isPending
            ? const Color(0xFFFEF3C7)
            : const Color(0xFFCFFAFE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isPending
              ? const Color(0xFF92400E)
              : const Color(0xFF155E75),
        ),
      ),
    );
  }
}
