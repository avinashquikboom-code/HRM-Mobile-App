import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/widgets/core/glass_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {'title': 'Payroll Processed', 'time': '2h ago', 'icon': LucideIcons.wallet, 'desc': 'June payroll for 42 employees has been successfully processed.'},
      {'title': 'Leave Request', 'time': '5h ago', 'icon': LucideIcons.calendar, 'desc': 'Avinash Magar has requested sick leave for 2 days.'},
      {'title': 'Security Alert', 'time': 'Yesterday', 'icon': LucideIcons.shieldAlert, 'desc': 'New login detected from a Chrome browser on Windows.'},
      {'title': 'Attendance Update', 'time': '2 days ago', 'icon': LucideIcons.userCheck, 'desc': 'Attendance rules for the Design department have been updated.'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Notifications', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        leading: const BackButton(color: AppColors.textPrimary),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final note = notifications[index];
          return GlassCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.hrPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(note['icon'] as IconData, color: AppColors.hrPrimary, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(note['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text(note['time'] as String, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(note['desc'] as String, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.4)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ).animate().fadeIn().slideY(begin: 0.1, end: 0),
    );
  }
}

class CompanyPoliciesScreen extends StatelessWidget {
  const CompanyPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final policies = [
      {'title': 'Leave Policy', 'size': '1.2 MB', 'icon': LucideIcons.fileText},
      {'title': 'Code of Conduct', 'size': '850 KB', 'icon': LucideIcons.shieldCheck},
      {'title': 'Work From Home', 'size': '2.1 MB', 'icon': LucideIcons.home},
      {'title': 'Travel Expense', 'size': '450 KB', 'icon': LucideIcons.plane},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Company Policies', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        leading: const BackButton(color: AppColors.textPrimary),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: const Text(
              'Download and review latest company guidelines and policy documents.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: policies.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final policy = policies[index];
                return GlassCard(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(policy['icon'] as IconData, color: AppColors.hrPrimary),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(policy['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(policy['size'] as String, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.download, size: 20, color: AppColors.hrPrimary),
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ).animate().fadeIn().slideX(begin: 0.1, end: 0),
    );
  }
}
