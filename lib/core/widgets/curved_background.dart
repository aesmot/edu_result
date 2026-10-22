
import 'package:flutter/material.dart';

/// Reusable blue curved background.
///
/// Can be used on Login, Register, and other screens.
class CurvedBackground extends StatelessWidget {
  const CurvedBackground({
    super.key,
    this.heightFactor = 0.4,
    this.color = const Color(0xFF2563EB),
    this.curveDepth = 50,
  });

  /// Background height as a fraction of screen height.
  final double heightFactor;

  /// Background color.
  final Color color;

  /// Controls the curve's vertical shape.
  final double curveDepth;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return ClipPath(
      clipper: _BackgroundClipper(
        curveDepth: curveDepth,
      ),
      child: Container(
        height: screenHeight * heightFactor,
        width: double.infinity,
        color: color,
      ),
    );
  }
}

class _BackgroundClipper extends CustomClipper<Path> {
  const _BackgroundClipper({
    required this.curveDepth,
  });

  final double curveDepth;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - curveDepth)
      ..quadraticBezierTo(
        size.width / 2,
        size.height,
        size.width,
        size.height - curveDepth,
      )
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant _BackgroundClipper oldClipper) {
    return oldClipper.curveDepth != curveDepth;
  }
}
