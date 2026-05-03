import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/widgets/core/gradient_button.dart';

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add New Staff', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.surface,
                    child: Icon(LucideIcons.user, size: 40, color: AppColors.hrPrimary.withValues(alpha: 0.4)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: AppColors.hrPrimary, shape: BoxShape.circle),
                      child: const Icon(LucideIcons.camera, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildField('Full Name', 'Enter employee name', LucideIcons.user),
            _buildField('Email Address', 'Enter work email', LucideIcons.mail),
            _buildField('Phone Number', 'Enter contact number', LucideIcons.phone),
            _buildField('Designation', 'e.g. Software Engineer', LucideIcons.briefcase),
            _buildField('Department', 'e.g. Engineering', LucideIcons.building),
            const SizedBox(height: 32),
            GradientButton(text: 'Onboard Employee', onPressed: () => Navigator.pop(context)),
            const SizedBox(height: 48),
          ].animate(interval: 50.ms).fadeIn().slideY(begin: 0.1, end: 0),
        ),
      ),
    );
  }

  Widget _buildField(String label, String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon, size: 20, color: AppColors.textSecondary),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
