import 'package:flutter/material.dart';

class DashboardStatCard extends StatelessWidget {
const DashboardStatCard({
super.key,
required this.title,
required this.value,
required this.icon,
required this.color,
});

final String title;
final String value;
final IconData icon;
final Color color;

@override
Widget build(BuildContext context) {
  return Card(
    elevation: 2,
    shadowColor: Colors.black26,
    color: Colors.white,
    surfaceTintColor: Colors.transparent,
    margin: const EdgeInsets.all(3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 6,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 38,
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    height: 1.1,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}