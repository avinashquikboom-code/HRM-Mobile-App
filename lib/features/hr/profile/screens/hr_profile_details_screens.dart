import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:hrm/config/routes/app_router.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/widgets/core/glass_card.dart';

class ProfileSubScreen extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ProfileSubScreen({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(title, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        leading: const BackButton(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSubScreen(
      title: 'Personal Information',
      children: [
        _buildInfoItem('Full Name', 'Priya Singh'),
        _buildInfoItem('Email', 'priya.singh@hrm.com'),
        _buildInfoItem('Phone', '+91 98765 43210'),
        _buildInfoItem('Designation', 'HR Manager'),
        _buildInfoItem('Department', 'Human Resources'),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.hrPrimary),
          child: const Text('Edit Information', style: TextStyle(color: Colors.white)),
        ),
      ].animate(interval: 50.ms).fadeIn().slideX(begin: 0.1, end: 0),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const Divider(height: 24),
        ],
      ),
    );
  }
}

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSubScreen(
      title: 'Security',
      children: [
        _buildSecurityItem(context, LucideIcons.lock, 'Change Password', 'Update your password regularly', onTap: () => context.push(AppRouter.profileChangePassword)),
        _buildSecurityItem(context, LucideIcons.fingerprint, 'Biometric Authentication', 'Use Face ID or Fingerprint', onTap: () => context.push(AppRouter.profileBiometric)),
        _buildSecurityItem(context, LucideIcons.shieldCheck, 'Two-Factor Auth', 'Secure your account with 2FA', onTap: () => context.push(AppRouter.profileTwoFactor)),
        _buildSecurityItem(context, LucideIcons.smartphone, 'Active Devices', 'Manage devices currently logged in', onTap: () => context.push(AppRouter.profileDevices)),
      ].animate(interval: 50.ms).fadeIn().slideX(begin: 0.1, end: 0),
    );
  }

  Widget _buildSecurityItem(BuildContext context, IconData icon, String title, String subtitle, {VoidCallback? onTap}) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: AppColors.hrPrimary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            const Icon(LucideIcons.chevronRight, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

class CompanyStructureScreen extends StatelessWidget {
  const CompanyStructureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSubScreen(
      title: 'Company Structure',
      children: [
        _buildStructureItem('Engineering', '24 Employees'),
        _buildStructureItem('Design', '8 Employees'),
        _buildStructureItem('HR & Admin', '4 Employees'),
        _buildStructureItem('Sales & Marketing', '6 Employees'),
      ].animate(interval: 50.ms).fadeIn().slideX(begin: 0.1, end: 0),
    );
  }

  Widget _buildStructureItem(String dept, String count) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(dept, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(count, style: const TextStyle(color: AppColors.hrPrimary, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
