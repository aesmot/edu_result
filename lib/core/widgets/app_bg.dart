import 'package:flutter/material.dart';

class AppBg extends StatelessWidget {
  final Widget child;

  const AppBg({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF14B8A6), // Teal
            Color(0xFF2563EB), // Blue
            Color(0xFF4F46E5), // Indigo
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}

///
/// Scaffold(
//   body: AppBackground(
//     child: SafeArea(
//       child: Center(
//         child: Text(
//           'Admin Dashboard',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     ),
//   ),
// );