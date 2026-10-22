import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class LoginBackground extends StatelessWidget {
  final Widget child; // Ekhane form ba onno widget pass kora hobe

  const LoginBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              // ১. উপরের ব্যাকগ্রাউন্ড ও কার্ভ পার্ট
              ClipPath(
                clipper: BackgroundClipper(),
                child: Container(
                  height: size.height * 0.45,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryGradientStart,
                        AppColors.primaryGradientEnd,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  // Ekhane Center-er bodole Padding ba Align use korbo
                  child: Container(
                    alignment: Alignment.topCenter, // Upore align korbe
                    padding: const EdgeInsets.only(top: 80.0), // Upor theke space dibe
                    child: const Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
//SizedBox(height: 40,),
              // ২. মাঝখানের ফর্ম বা কার্ড
              Positioned(
                top: size.height * 0.28,
                left: 20,
                right: 20,
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Clipper
class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);

    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 50);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}