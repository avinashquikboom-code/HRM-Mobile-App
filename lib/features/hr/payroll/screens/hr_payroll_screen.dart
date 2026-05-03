import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:hrm/config/routes/app_router.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/widgets/core/glass_card.dart';

class HRPayrollScreen extends StatelessWidget {
  const HRPayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Payroll Management', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.history, color: AppColors.textPrimary), 
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
            _buildPayrollSummary(),
            const SizedBox(height: 32),
            _buildSectionHeader('Employee Payroll', 'June 2024'),
            const SizedBox(height: 16),
            _buildEmployeePayrollList(),
            const SizedBox(height: 140), // Space for FAB and Nav Bar
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 160.0), // Aggressive padding to clear all elements
        child: FloatingActionButton.extended(
          onPressed: () => context.push(AppRouter.hrRunPayroll),
          backgroundColor: AppColors.hrPrimary,
          elevation: 8,
          label: const Text('Run Payroll', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          icon: const Icon(LucideIcons.playCircle, color: Colors.white),
        ).animate().scale(delay: 400.ms, curve: Curves.easeOutBack),
      ),
    );
  }

  Widget _buildPayrollSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.hrGradient,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.hrPrimary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Payroll Outflow', style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 8),
          const Text('₹12,84,500', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _summaryItem('Employees', '42'),
              _summaryItem('Tax/Deductions', '₹1.2L'),
              _summaryItem('Status', 'Pending'),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  Widget _summaryItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        Text(action, style: const TextStyle(color: AppColors.hrPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
      ],
    );
  }

  Widget _buildEmployeePayrollList() {
    final employees = [
      {'name': 'Avinash Magar', 'role': 'Lead', 'amount': '₹85,000', 'status': 'Processed'},
      {'name': 'Rahul Kumar', 'role': 'Designer', 'amount': '₹65,000', 'status': 'Pending'},
      {'name': 'Priya Singh', 'role': 'HR', 'amount': '₹75,000', 'status': 'Processed'},
      {'name': 'Amit Shah', 'role': 'Backend', 'amount': '₹70,000', 'status': 'Processed'},
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: employees.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final emp = employees[index];
        final isProcessed = emp['status'] == 'Processed';
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
                    Text(emp['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(emp['role']!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(emp['amount']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(
                    emp['status']!,
                    style: TextStyle(
                      color: isProcessed ? AppColors.success : AppColors.warning,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).animate().fadeIn(delay: 300.ms);
  }
}
