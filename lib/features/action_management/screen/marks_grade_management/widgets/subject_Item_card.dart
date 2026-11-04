import 'package:flutter/material.dart';
import 'package:result_management_system/core/constant/app_colors.dart';

// আপনার তৈরি করা আলাদা ডিজাইন উইজেটগুলো এখানে ইমপোর্ট করুন
// (অথবা একই ফাইলে রাখলে ইমপোর্টের প্রয়োজন নেই)
import 'subject_edit_card_widget.dart';
import 'subject_view_card_widget.dart';

class SubjectItemCard extends StatefulWidget {
  final String subjectName;
  final String subtitle;
  final int classNum;

  const SubjectItemCard({
    super.key,
    required this.subjectName,
    required this.subtitle,
    required this.classNum,
  });

  @override
  State<SubjectItemCard> createState() => _SubjectItemCardState();
}

class _SubjectItemCardState extends State<SubjectItemCard> {
  bool isEditing = false; // এডিট মোড অন/অফ ট্র্যাক করার জন্য

  // ডিফল্ট মার্কস কন্ট্রোলার
  late TextEditingController mcqController;
  late TextEditingController writtenController;

  @override
  void initState() {
    super.initState();
    mcqController = TextEditingController(text: '25');
    writtenController = TextEditingController(text: '75');
  }

  @override
  void dispose() {
    mcqController.dispose();
    writtenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int mcq = int.tryParse(mcqController.text) ?? 0;
    int written = int.tryParse(writtenController.text) ?? 0;
    int total = mcq + written;

    // যদি isEditing true হয়, তবে এডিট কার্ড দেখাবে
    if (isEditing) {
      return SubjectEditCardWidget(
        subjectName: widget.subjectName,
        mcqController: mcqController,
        writtenController: writtenController,
        total: total,
        onSavePressed: () {
          // TODO: Save logic here
          setState(() {
            isEditing = false;
          });
        },
        onCancelPressed: () {
          setState(() {
            isEditing = false;
          });
        },
        onChanged: (_) => setState(() {}),
      );
    }

    // স্বাভাবিক নরমাল ভিউ মোড
    return SubjectViewCardWidget(
      subjectName: widget.subjectName,
      subtitle: widget.subtitle,
      onTap: () {
        debugPrint(
          'Selected: ${widget.subjectName} for Class ${widget.classNum}',
        );
      },
      onEditPressed: () {
        setState(() {
          isEditing = true;
        });
      },
    );
  }
}