


import 'package:flutter/cupertino.dart';

class SectionHeading extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionHeading({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF5B61D6),
          size: 22,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: Color(0xFF303650),
            ),
          ),
        ),
      ],
    );
  }
}