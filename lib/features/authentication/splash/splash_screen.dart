import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Splash Screen
///
/*
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  // Logo Scale Animation
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
// Add this line to track the timer instance
  Timer? _splashTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.65,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
    _checkFirstTimeOpen();
  }

  @override
  void dispose() {
    _splashTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _checkFirstTimeOpen() async {
    var box = await Hive.openBox('firstUser');

    bool isFirstTime = box.get(
      'isFirstTime',
      defaultValue: true,
    );

    if (isFirstTime) {
      _splashTimer = Timer(const Duration(seconds: 3), () async {
        await box.put('isFirstTime', false);

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (_, animation, secondaryAnimation) =>
            const LoginScreen(),
            transitionsBuilder:
                (_, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      });
    }
    else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (_, animation, secondaryAnimation) =>
            const LoginScreen(),
            transitionsBuilder:
                (_, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      });
    }
  }

  // ==========================================================================
  // UI
  // ==========================================================================

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),
      body: Stack(
        children: [

          // Bottom decorative illustration
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: screenSize.height * 0.22,
              width: double.infinity,
              child: Image.asset(
                'assets/images/bk_splash_bottom.png',
                fit: BoxFit.fill,
              ),
            ),
          ),

          // App logo and tagline
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset(
                    'assets/images/bk_logo_splash.png',
                    width: screenWidth * .40,
                    height: screenWidth * .40,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Track. Manage. Save',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.logoTitle,
                ),

                const SizedBox(height: 8),

                const Text(
                    'Manage your daily expenses',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.emptyState),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/