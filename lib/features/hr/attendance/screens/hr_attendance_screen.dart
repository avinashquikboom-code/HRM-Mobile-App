import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/widgets/core/glass_card.dart';

class HRAttendanceScreen extends StatelessWidget {
  const HRAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Attendance Tracking', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.calendar, color: AppColors.textPrimary), 
            onPressed: () => showDatePicker(
              context: context, 
              initialDate: DateTime.now(), 
              firstDate: DateTime(2020), 
              lastDate: DateTime(2030),
              builder: (context, child) => Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(primary: AppColors.hrPrimary),
                ),
                child: child!,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAttendanceStats(),
            const SizedBox(height: 32),
            const Text('Live Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 16),
            _buildAttendanceList(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceStats() {
    return Row(
      children: [
        Expanded(child: _statItem('Present', '38/42', LucideIcons.userCheck, AppColors.success)),
        const SizedBox(width: 12),
        Expanded(child: _statItem('Late', '4', LucideIcons.clock, AppColors.warning)),
        const SizedBox(width: 12),
        Expanded(child: _statItem('Absent', '0', LucideIcons.userX, AppColors.error)),
      ],
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  Widget _statItem(String label, String value, IconData icon, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildAttendanceList() {
    final records = [
      {'name': 'Avinash Magar', 'time': '09:30 AM', 'status': 'On Time'},
      {'name': 'Rahul Kumar', 'time': '10:15 AM', 'status': 'Late'},
      {'name': 'Priya Singh', 'time': '09:15 AM', 'status': 'On Time'},
      {'name': 'Amit Shah', 'time': '09:45 AM', 'status': 'On Time'},
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: records.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final rec = records[index];
        final isLate = rec['status'] == 'Late';
        return GlassCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.hrPrimary.withValues(alpha: 0.1),
                child: const Icon(LucideIcons.user, color: AppColors.hrPrimary, size: 18),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(rec['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('Punched In at ${rec['time']}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (isLate ? AppColors.warning : AppColors.success).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  rec['status']!,
                  style: TextStyle(
                    color: isLate ? AppColors.warning : AppColors.success,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).animate().fadeIn(delay: 300.ms);
  }
}
