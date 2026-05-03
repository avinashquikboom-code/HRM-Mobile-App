import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hrm/core/constants/app_colors.dart';

class EmployeeShell extends StatelessWidget {
  const EmployeeShell({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for floating nav bar
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 70,
          margin: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _navItem(0, LucideIcons.home, 'Home'),
                    _navItem(1, LucideIcons.fingerprint, 'Attendance'),
                    _navItem(2, LucideIcons.wallet, 'Salary'),
                    _navItem(3, LucideIcons.calendar, 'Leave'),
                    _navItem(4, LucideIcons.user, 'Profile'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ).animate().slideY(begin: 1, end: 0, duration: 600.ms, curve: Curves.easeOutQuart),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final isActive = navigationShell.currentIndex == index;
    return GestureDetector(
      onTap: () => navigationShell.goBranch(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isActive)
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack),
            Icon(
              icon,
              color: isActive ? Colors.white : AppColors.textSecondary.withValues(alpha: 0.6),
              size: 24,
            ).animate(target: isActive ? 1 : 0).scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
          ],
        ),
      ),
    );
  }
}
