import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/widgets/core/glass_card.dart';
import 'package:hrm/widgets/core/gradient_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Change Password', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildPasswordField('Current Password'),
            const SizedBox(height: 16),
            _buildPasswordField('New Password'),
            const SizedBox(height: 16),
            _buildPasswordField('Confirm New Password'),
            const SizedBox(height: 32),
            GradientButton(text: 'Update Password', onPressed: () {}),
          ],
        ).animate().fadeIn().slideY(begin: 0.1, end: 0),
      ),
    );
  }

  Widget _buildPasswordField(String label) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(LucideIcons.lock, size: 20),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }
}

class BiometricAuthScreen extends StatelessWidget {
  const BiometricAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Biometric Auth')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.fingerprint, size: 80, color: AppColors.hrPrimary),
            const SizedBox(height: 24),
            const Text('Use Biometrics to Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('Secure your account using Face ID or Fingerprint', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 48),
            SwitchListTile(
              title: const Text('Enable Biometrics'),
              value: true,
              onChanged: (v) {},
              activeThumbColor: AppColors.hrPrimary,
            ),
          ],
        ).animate().scale(),
      ),
    );
  }
}

class TwoFactorAuthScreen extends StatelessWidget {
  const TwoFactorAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Two-Factor Auth')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(LucideIcons.shieldCheck, size: 64, color: AppColors.success),
            const SizedBox(height: 24),
            const Text('Two-Factor Authentication is ON', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('A verification code will be sent to your registered phone number.', textAlign: TextAlign.center),
            const SizedBox(height: 32),
            GlassCard(
              child: ListTile(
                title: const Text('Phone Number'),
                subtitle: const Text('+91 ******3210'),
                trailing: const Text('Change', style: TextStyle(color: AppColors.hrPrimary)),
              ),
            ),
          ],
        ).animate().fadeIn(),
      ),
    );
  }
}

class ActiveDevicesScreen extends StatelessWidget {
  const ActiveDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final devices = [
      {'name': 'iPhone 13 Pro', 'loc': 'Mumbai, India', 'icon': LucideIcons.smartphone, 'status': 'Current Device'},
      {'name': 'Windows PC', 'loc': 'Pune, India', 'icon': LucideIcons.monitor, 'status': 'Active 2h ago'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Active Devices')),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: devices.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final device = devices[index];
          return GlassCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(device['icon'] as IconData, color: AppColors.hrPrimary),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(device['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(device['loc'] as String, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    ],
                  ),
                ),
                Text(device['status'] as String, style: const TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          );
        },
      ).animate().fadeIn(),
    );
  }
}
