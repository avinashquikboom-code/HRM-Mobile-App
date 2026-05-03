import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/widgets/core/glass_card.dart';
import 'package:hrm/widgets/core/gradient_button.dart';

class AttendancePolicyScreen extends StatelessWidget {
  const AttendancePolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Attendance Policy', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('Shift Timings'),
            _policyCard(LucideIcons.clock, 'General Shift', '09:00 AM - 06:00 PM', 'Buffer: 15 mins'),
            const SizedBox(height: 24),
            _sectionHeader('Late Rules'),
            _policyCard(LucideIcons.alertTriangle, 'Late Marking', '3 Days Late = 1 Half Day', 'Applicable to all departments'),
            const SizedBox(height: 24),
            _sectionHeader('Work From Home'),
            _policyCard(LucideIcons.home, 'WFH Limit', '2 Days / Month', 'Pre-approval required'),
            const SizedBox(height: 24),
            _sectionHeader('Holiday List 2024'),
            _holidayList(),
            const SizedBox(height: 32),
            GradientButton(text: 'Update Policies', onPressed: () {}),
            const SizedBox(height: 48),
          ].animate(interval: 50.ms).fadeIn().slideY(begin: 0.1, end: 0),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _policyCard(IconData icon, String title, String value, String footer) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.hrPrimary, size: 20),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const Spacer(),
              const Icon(LucideIcons.edit3, size: 16, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 16),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(footer, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _holidayList() {
    final holidays = [
      {'name': 'Independence Day', 'date': 'Aug 15'},
      {'name': 'Ganesh Chaturthi', 'date': 'Sep 07'},
      {'name': 'Gandhi Jayanti', 'date': 'Oct 02'},
      {'name': 'Diwali', 'date': 'Oct 31'},
    ];

    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: holidays.map((h) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(h['name']!, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(h['date']!, style: const TextStyle(color: AppColors.hrPrimary, fontWeight: FontWeight.bold)),
            ],
          ),
        )).toList(),
      ),
    );
  }
}
