import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/widgets/core/glass_card.dart';
import 'package:hrm/widgets/core/gradient_button.dart';

class RunPayrollScreen extends StatefulWidget {
  const RunPayrollScreen({super.key});

  @override
  State<RunPayrollScreen> createState() => _RunPayrollScreenState();
}

class _RunPayrollScreenState extends State<RunPayrollScreen> {
  int _currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Process Payroll', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          _buildStepHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: _buildCurrentStepView(),
            ),
          ),
          _buildActionFooter(),
        ],
      ),
    );
  }

  Widget _buildStepHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        border: Border(bottom: BorderSide(color: AppColors.textSecondary.withValues(alpha: 0.1))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _stepIndicator(1, 'Verify', LucideIcons.checkCircle),
          _stepLine(),
          _stepIndicator(2, 'Review', LucideIcons.fileSearch),
          _stepLine(),
          _stepIndicator(3, 'Disburse', LucideIcons.send),
        ],
      ),
    );
  }

  Widget _stepIndicator(int step, String label, IconData icon) {
    bool isActive = _currentStep == step;
    bool isCompleted = _currentStep > step;
    Color color = isCompleted ? AppColors.success : (isActive ? AppColors.hrPrimary : AppColors.textSecondary);

    return Column(
      children: [
        AnimatedContainer(
          duration: 300.ms,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(isCompleted ? LucideIcons.check : icon, color: color, size: 18),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _stepLine() {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
        decoration: BoxDecoration(
          color: AppColors.textSecondary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }

  Widget _buildCurrentStepView() {
    switch (_currentStep) {
      case 1: return _buildVerificationView();
      case 2: return _buildReviewView();
      case 3: return _buildDisbursementView();
      default: return const SizedBox();
    }
  }

  Widget _buildVerificationView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Attendance Verification', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Ensure all staff records are finalized for June 2024.', style: TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 24),
        _verificationCard('Total Employees', '42 Active', LucideIcons.users, AppColors.hrPrimary),
        _verificationCard('Present Days', '98.4%', LucideIcons.userCheck, AppColors.success),
        _verificationCard('Leave Days', '12 Total', LucideIcons.calendarX, AppColors.warning),
        _verificationCard('Unmarked Attendance', '0 Pending', LucideIcons.alertCircle, AppColors.success),
      ].animate(interval: 50.ms).fadeIn().slideX(begin: 0.1, end: 0),
    );
  }

  Widget _verificationCard(String label, String value, IconData icon, Color color) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
          const Icon(LucideIcons.checkCircle2, color: AppColors.success, size: 20),
        ],
      ),
    );
  }

  Widget _buildReviewView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Calculation Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: AppColors.hrGradient,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              _summaryRow('Net Payable', '₹12,84,500', isLarge: true),
              const Divider(color: Colors.white24, height: 32),
              _summaryRow('Gross Salary', '₹15,42,000'),
              _summaryRow('Total Deductions', '-₹2,57,500'),
            ],
          ),
        ),
        const SizedBox(height: 32),
        const Text('Detailed Breakdown', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _breakdownItem('Basic Salary', '₹10,50,000'),
        _breakdownItem('HRA & Allowances', '₹4,92,000'),
        _breakdownItem('Tax (TDS)', '-₹1,20,000'),
        _breakdownItem('PF & Insurance', '-₹1,37,500'),
      ].animate(interval: 50.ms).fadeIn().slideX(begin: 0.1, end: 0),
    );
  }

  Widget _summaryRow(String label, String value, {bool isLarge = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.white70, fontSize: isLarge ? 16 : 14)),
        Text(value, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: isLarge ? 24 : 16)),
      ],
    );
  }

  Widget _breakdownItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildDisbursementView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.shieldCheck, size: 64, color: AppColors.success),
          ),
          const SizedBox(height: 32),
          const Text('Verification Successful', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text(
            'The payroll cycle for June 2024 is ready for final disbursement. 42 transactions will be initiated.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, height: 1.5),
          ),
          const SizedBox(height: 40),
          GlassCard(
            child: Row(
              children: [
                const Icon(LucideIcons.info, size: 20, color: AppColors.hrPrimary),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Ensure sufficient balance in the corporate account before confirming.',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ).animate().scale(),
    );
  }

  Widget _buildActionFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.textSecondary.withValues(alpha: 0.1))),
      ),
      child: Row(
        children: [
          if (_currentStep > 1) ...[
            Expanded(
              flex: 1,
              child: OutlinedButton(
                onPressed: () => setState(() => _currentStep--),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Icon(LucideIcons.chevronLeft),
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            flex: 3,
            child: GradientButton(
              text: _currentStep == 1 
                ? 'Finalize Verification' 
                : _currentStep == 2 
                  ? 'Approve Calculation' 
                  : 'Confirm Disbursement',
              onPressed: () {
                if (_currentStep < 3) {
                  setState(() => _currentStep++);
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
