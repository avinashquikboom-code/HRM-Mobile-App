import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/widgets/core/glass_card.dart';

class HRReportsScreen extends StatelessWidget {
  const HRReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Reports & Analytics', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExpenseReport(),
            const SizedBox(height: 32),
            _buildSectionHeader('Department Analytics'),
            const SizedBox(height: 16),
            _buildDepartmentList(),
            const SizedBox(height: 12),
            _buildSectionHeader('Monthly Trends'),
            const SizedBox(height: 16),
            _buildTrendsChart(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseReport() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Monthly Expense', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
              const Icon(LucideIcons.trendingUp, color: AppColors.success, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          const Text('₹15,42,000', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 24),
          Row(
            children: [
              _expenseBadge('Payroll: 85%', AppColors.hrPrimary),
              const SizedBox(width: 12),
              _expenseBadge('Ops: 15%', AppColors.accent),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: -0.1, end: 0);
  }

  Widget _expenseBadge(String label, Color color) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary));
  }

  Widget _buildDepartmentList() {
    final depts = [
      {'name': 'Engineering', 'count': '24', 'health': '95%'},
      {'name': 'Design', 'count': '8', 'health': '88%'},
      {'name': 'HR & Admin', 'count': '4', 'health': '92%'},
      {'name': 'Sales', 'count': '6', 'health': '82%'},
    ];

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: depts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final dept = depts[index];
        return GlassCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dept['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(dept['count']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(dept['health']!, style: const TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        );
      },
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildTrendsChart() {
    return Container(
      height: 180,
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: AppColors.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [0.4, 0.6, 0.8, 0.5, 0.9, 0.7, 0.85].map((val) => _bar(val)).toList(),
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _bar(double factor) {
    return Container(
      width: 20,
      height: 120 * factor,
      decoration: BoxDecoration(
        color: AppColors.hrPrimary.withValues(alpha: factor),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
