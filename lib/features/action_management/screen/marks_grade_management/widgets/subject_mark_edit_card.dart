import 'package:flutter/material.dart';

class SubjectMarkEditCard extends StatefulWidget {
  final String subjectName;
  final int initialMcq;
  final int initialWritten;
  final Function(int mcq, int written) onSave;

  const SubjectMarkEditCard({
    super.key,
    required this.subjectName,
    required this.initialMcq,
    required this.initialWritten,
    required this.onSave,
  });

  @override
  State<SubjectMarkEditCard> createState() => _SubjectMarkEditCardState();
}

class _SubjectMarkEditCardState extends State<SubjectMarkEditCard> {
  late TextEditingController mcqController;
  late TextEditingController writtenController;

  @override
  void initState() {
    super.initState();
    mcqController = TextEditingController(text: widget.initialMcq.toString());
    writtenController = TextEditingController(text: widget.initialWritten.toString());
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D1F24),
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        widget.onSave(mcq, written);
                      },
                      icon: const Icon(Icons.save, size: 16),
                      label: const Text(
                        'Save',
                        style: TextStyle(fontWeight: FontWeight.w600),
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
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Reset values to initial
                      setState(() {
                        mcqController.text = widget.initialMcq.toString();
                        writtenController.text = widget.initialWritten.toString();
                      });
                    },
                    icon: const Icon(Icons.close, size: 16),
                    label: const Text(
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.w600),
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
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 55,
                  height: 38,
                  child: TextField(
                    controller: mcqController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 55,
                  height: 38,
                  child: TextField(
                    controller: writtenController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}