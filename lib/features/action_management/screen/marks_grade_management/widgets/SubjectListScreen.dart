import 'package:flutter/material.dart';
import 'package:result_management_system/core/constant/app_colors.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({
    super.key,
    required this.classNum,
  });

  final int classNum;

  // Class অনুযায়ী Subject List
  List<String> _getSubjectsForClass(int classNum) {
    if (classNum >= 9) {
      return [
        'Bangla 1st Paper',
        'Bangla 2nd Paper',
        'English 1st Paper',
        'English 2nd Paper',
        'Mathematics',
        'ICT',
        'Physics',
        'Chemistry',
        'Biology',
      ];
    } else {
      return [
        'Bangla',
        'English',
        'Mathematics',
        'Science',
        'ICT',
        'Bangladesh & Global Studies',
        'Islam & Moral Education',
      ];
    }
  }

  // প্রতিটি Subject-এর আলাদা Subtitle
  static const Map<String, String> subjectSubtitles = {
    'Bangla 1st Paper': 'Mcq 25, Written 75 = Total 100',
    'Bangla 2nd Paper': 'Manage Bangla 2nd Paper marks',
    'English 1st Paper': 'Manage English 1st Paper marks',
    'English 2nd Paper': 'Manage English 2nd Paper marks',
    'Mathematics': 'Manage Mathematics marks',
    'ICT': 'Written Mark 50, MCQ Mark 25 Practical Mark 25. Total 100',
    'Physics': 'Manage Physics marks',
    'Chemistry': 'Manage Chemistry marks',
    'Biology': 'Manage Biology marks',
    'Bangla': 'Manage Bangla marks',
    'English': 'Manage English marks',
    'Science': 'Manage Science marks',
    'Bangladesh & Global Studies': 'Manage BGS marks',
    'Islam & Moral Education': 'Manage Islamic Studies marks',
  };

  @override
  Widget build(BuildContext context) {
    final subjects = _getSubjectsForClass(classNum);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: Text(
          'Class $classNum Subjects',
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF1E293B),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subjectName = subjects[index];
                final subtitle = subjectSubtitles[subjectName] ??
                    'Manage marks & student results';

                // প্রতিটা সাবজেক্টের জন্য தனி Stateful আইটেম উইজেট কল করা হলো
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SubjectItemCard(
                    subjectName: subjectName,
                    subtitle: subtitle,
                    classNum: classNum,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// আলাদা একটি Stateful উইজেট যা View Mode এবং Edit Mode হ্যান্ডেল করবে
// ----------------------------------------------------
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

  // ডিফল্ট মার্কস (আপনার ডাটাবেজ বা প্রজেক্ট অনুযায়ী ইনিশিয়াল ভ্যালু বসিয়ে নিতে পারেন)
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

    // যদি isEditing true হয়, তবে আপনার ডিজাইন করা এডিট কার্ড দেখাবে
    if (isEditing) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Subject Name & Action Buttons (Save & Cancel)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.subjectName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Row(
                  children: [
                    // Blue Gradient Save Button
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF38B6FF), Color(0xFF007AFF)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(0, 32),
                        ),
                        onPressed: () {
                          // TODO: Save logic here
                          setState(() {
                            isEditing = false;
                          });
                        },
                        icon: const Icon(Icons.save, size: 14),
                        label: const Text(
                          'Save',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Cancel Button
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(0, 32),
                      ),
                      onPressed: () {
                        setState(() {
                          isEditing = false;
                        });
                      },
                      icon: const Icon(Icons.close, size: 14),
                      label: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Bottom Row: Inputs for MCQ, Written & Total
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Text(
                    'Mcq',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 55,
                    height: 35,
                    child: TextField(
                      controller: mcqController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF007AFF)),
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Written',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 55,
                    height: 35,
                    child: TextField(
                      controller: writtenController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF007AFF)),
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Total  $total',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // স্বাভাবিক নরমাল ভিউ মোড
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          debugPrint(
            'Selected: ${widget.subjectName} for Class ${widget.classNum}',
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.cardBorder,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.menu_book_rounded,
                    color: AppColors.primaryGradientStart,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.subjectName,
                      style: const TextStyle(
                        color: Color(0xFF1E293B),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // এই এডিট আইকনে ক্লিক করলেই এডিট মোড অন হয়ে যাবে
              IconButton(
                icon: const Icon(
                  Icons.edit_rounded,
                  size: 16,
                  color: Color(0xFF94A3B8),
                ),
                onPressed: () {
                  setState(() {
                    isEditing = true;
                  });
                },
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Color(0xFF94A3B8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}