import 'package:flutter/material.dart';
import 'package:result_management_system/core/constant/app_colors.dart';

import 'SubjectListScreen.dart';

class ClassListScreen extends StatelessWidget {
  const ClassListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 10 theke 1 porjonto list generate kora (ekhane '-' sign-ti thakbe)
    final List<int> classes = List.generate(10, (index) => 10 - index);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final classNum = classes[index];
        final isPinkTheme = classNum >= 9;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: () {
                debugPrint('Class clicked: $classNum');

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SubjectListScreen(
                      classNum: classNum,
                    ),
                  ),
                );
              },

              borderRadius: BorderRadius.circular(16),
              child: Ink(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.cardBorder,
                  ),
                ),
                child: Row(
                  children: [
                    // Bame Serial Container (Class Number)
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isPinkTheme
                            ? const Color(0xFFFFEBEE)
                            : const Color(0xFFF0F4FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          classNum < 10 ? '0$classNum' : '$classNum',
                          style: TextStyle(
                            color: isPinkTheme
                                ? const Color(0xFFE53935)
                                : AppColors.primaryGradientStart,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Majhe Title and Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Class $classNum',
                            style: const TextStyle(
                              color: Color(0xFF1E293B),
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            'Subject List & Results',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Dane Arrow Icon
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Color(0xFF94A3B8),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}