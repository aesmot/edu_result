
import 'package:flutter/material.dart';
import 'mark_entry_table_header.dart';

import 'student_mark_row.dart';

/// Student marks table with a horizontally scrollable layout.
class MarkEntryTable extends StatelessWidget {
  const MarkEntryTable({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 780,
            child: Column(
              children: [const MarkEntryTableHeader(),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }


}

const _headerStyle = TextStyle(
  color: Colors.white,
  fontSize: 12,
  fontWeight: FontWeight.w600,
);
