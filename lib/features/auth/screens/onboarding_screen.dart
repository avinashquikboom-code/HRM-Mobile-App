import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/config/routes/app_router.dart';
import 'package:hrm/widgets/core/gradient_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Effortless Payroll',
      subtitle: 'Automated & Precise',
      description: 'Manage salaries, bonuses, and deductions with a single tap. Automated and accurate processing for your peace of mind.',
      icon: LucideIcons.wallet,
      color: AppColors.primary,
      accentColor: const Color(0xFFE6F4F1), // Very light teal
    ),
    OnboardingData(
      title: 'Smart Attendance',
      subtitle: 'Real-time Tracking',
      description: 'Track attendance with GPS, Selfie, or QR codes. Get real-time insights and automated timesheets for your workforce.',
      icon: LucideIcons.fingerprint,
      color: AppColors.primaryLight,
      accentColor: const Color(0xFFF0F9F7),
    ),
    OnboardingData(
      title: 'Enterprise Analytics',
      subtitle: 'Data-Driven Growth',
      description: 'Deep dive into employee performance and payroll expenses with beautiful interactive charts and reports.',
      icon: LucideIcons.barChart3,
      color: AppColors.accent,
      accentColor: const Color(0xFFFEF9F1), // Very light gold
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ..._buildBackgroundElements(),
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) => setState(() => _currentPage = value),
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return _buildPage(_pages[index]);
                    },
                  ),
                ),
                _buildBottomSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBackgroundElements() {
    return [
      Positioned(
        top: -100,
        right: -100,
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: _pages[_currentPage].color.withValues(alpha: 0.05),
            shape: BoxShape.circle,
          ),
        ),
      ),
      Positioned(
        bottom: -50,
        left: -50,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: _pages[_currentPage].color.withValues(alpha: 0.03),
            shape: BoxShape.circle,
          ),
        ),
      ),
    ];
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'HRM',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              letterSpacing: -0.5,
            ),
          ),
          TextButton(
            onPressed: () => context.go(AppRouter.login),
            child: const Text(
              'Skip',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.2, end: 0);
  }

  Widget _buildPage(OnboardingData data) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: data.accentColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: data.color.withValues(alpha: 0.2),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Icon(data.icon, size: 64, color: data.color),
                ),
              ),
            ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 32),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: data.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    data.subtitle.toUpperCase(),
                    style: TextStyle(
                      color: data.color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  data.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 300.ms).moveY(begin: 30, end: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => AnimatedContainer(
                duration: 300.ms,
                margin: const EdgeInsets.only(right: 8),
                height: 8,
                width: _currentPage == index ? 32 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: GradientButton(
                  text: _currentPage == _pages.length - 1 ? 'Get Started' : 'Continue',
                  onPressed: () {
                    if (_currentPage < _pages.length - 1) {
                      _pageController.nextPage(duration: 600.ms, curve: Curves.easeInOutQuart);
                    } else {
                      context.go(AppRouter.login);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0);
  }
}

class OnboardingData {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final Color accentColor;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.accentColor,
  });
}
