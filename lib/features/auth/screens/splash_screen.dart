import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/config/routes/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Hide status bar on splash
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      // Restore status bar
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      context.go(AppRouter.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.bolt_rounded,
                size: 60,
                color: AppColors.primary,
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 2.seconds, color: AppColors.primaryLight.withValues(alpha: 0.3))
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.1, 1.1), duration: 1.seconds, curve: Curves.easeInOut)
                .then()
                .scale(begin: const Offset(1.1, 1.1), end: const Offset(0.8, 0.8), duration: 1.seconds, curve: Curves.easeInOut),
            const SizedBox(height: 24),
            Text(
              'HRM',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
            ).animate().fadeIn(delay: 500.ms).moveY(begin: 20, end: 0),
            const SizedBox(height: 8),
            Text(
              'Premium Payroll & HR',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                    letterSpacing: 2,
                  ),
            ).animate().fadeIn(delay: 800.ms),
          ],
        ),
      ),
    );
  }
}
