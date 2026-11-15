import 'package:flutter/material.dart';

class AdminResultTableWireframe extends StatelessWidget {
  const AdminResultTableWireframe({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            fontSize: 13,
          ),
          dataRowHeight: 52,
          columns: const [
            DataColumn(label: Text('Roll')),
            DataColumn(label: Text('Student Name')),
            DataColumn(label: Text('Bangla')),
            DataColumn(label: Text('English')),
            DataColumn(label: Text('Math')),
            DataColumn(label: Text('ICT')),
            DataColumn(label: Text('Total')),
            DataColumn(label: Text('GPA')),
            DataColumn(label: Text('Grade')),
            DataColumn(label: Text('Merit')),
          ],
          rows: [
            _buildDataRow(
              roll: '01',
              name: 'Esmot Ara',
              marks: ['85', '78', '95', '48'], // Science বাদ দেওয়া হয়েছে
              total: '306',
              gpa: '4.80',
              grade: 'A+',
              merit: '1st',
            ),
            _buildDataRow(
              roll: '02',
              name: 'Rahat Ahmed',
              marks: ['72', '80', '88', '45'], // Science বাদ দেওয়া হয়েছে
              total: '285',
              gpa: '4.40',
              grade: 'A',
              merit: '2nd',
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow({
    required String roll,
    required String name,
    required List<String> marks,
    required String total,
    required String gpa,
    required String grade,
    required String merit,
  }) {
    return DataRow(
      cells: [
        DataCell(Text(roll, style: const TextStyle(fontWeight: FontWeight.w600))),
        DataCell(Text(name, style: const TextStyle(fontWeight: FontWeight.w500))),
        ...marks.map((m) => DataCell(Text(m))),
        DataCell(Text(total, style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(gpa, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: grade == 'F' ? Colors.red.shade50 : Colors.green.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              grade,
              style: TextStyle(
                color: grade == 'F' ? Colors.red : Colors.green.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              merit,
              style: const TextStyle(color: Color(0xFF4F46E5), fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}