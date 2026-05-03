import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/widgets/core/glass_card.dart';

class AttendanceRulesScreen extends StatelessWidget {
  const AttendanceRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Attendance Rules', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderInfo(),
            const SizedBox(height: 32),
            const Text(
              'Key Policies',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            _buildRuleItem(
              'Standard Shift Timing',
              'Your standard working hours are from 09:30 AM to 06:30 PM. You must punch in before 09:45 AM to avoid a late mark.',
              LucideIcons.clock,
              AppColors.primary,
            ),
            const SizedBox(height: 16),
            _buildRuleItem(
              'Late Punch-In Penalties',
              'Accumulating 3 late marks in a month will result in a half-day deduction. More than 5 late marks may lead to a full-day deduction.',
              LucideIcons.alertTriangle,
              AppColors.warning,
            ),
            const SizedBox(height: 16),
            _buildRuleItem(
              'Missed Punch-Out',
              'Failing to punch out at the end of the day will require manual approval from your manager. Frequent missed punches may lead to unpaid days.',
              LucideIcons.userX,
              AppColors.error,
            ),
            const SizedBox(height: 16),
            _buildRuleItem(
              'Overtime Policy',
              'Overtime is calculated for any hours worked beyond 9.5 hours (including breaks) on a standard working day, subject to manager pre-approval.',
              LucideIcons.timer,
              AppColors.success,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        boxShadow: AppColors.softShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.bookOpen, color: AppColors.primary, size: 28),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Important Guidelines',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                SizedBox(height: 4),
                Text(
                  'Please adhere to these rules to maintain compliance and ensure proper payroll processing.',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.1, end: 0);
  }

  Widget _buildRuleItem(String title, String description, IconData icon, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.1, end: 0);
  }
}
