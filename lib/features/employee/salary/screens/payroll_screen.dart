import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hrm/core/constants/app_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/features/employee/salary/bloc/payroll_bloc.dart';
import 'package:hrm/features/employee/salary/bloc/payroll_event.dart';
import 'package:hrm/features/employee/salary/bloc/payroll_state.dart';
import 'package:hrm/config/injection/dependency_injection.dart';
import 'package:intl/intl.dart';

class PayrollScreen extends StatelessWidget {
  const PayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PayrollBloc>()..add(const LoadPayrollEvent('1')),
      child: const PayrollView(),
    );
  }
}

class PayrollView extends StatelessWidget {
  const PayrollView({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Payroll', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<PayrollBloc, PayrollState>(
        builder: (context, state) {
          if (state is PayrollLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PayrollLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSalarySummary(state, currencyFormatter),
                  const SizedBox(height: 32),
                  _buildBreakdown(state, currencyFormatter),
                  const SizedBox(height: 32),
                  _buildPaymentHistory(state.history, currencyFormatter),
                ],
              ),
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  Widget _buildSalarySummary(PayrollLoaded state, NumberFormat formatter) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const Text('Net Salary Payable', style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 8),
          Text(
            formatter.format(state.netSalary),
            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white10),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _summaryItem('Gross', formatter.format(state.basicSalary + state.hra + state.allowances)),
              _summaryItem('Deductions', formatter.format(state.deductions)),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().scale();
  }

  Widget _summaryItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildBreakdown(PayrollLoaded state, NumberFormat formatter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Salary Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _breakdownItem('Basic Salary', state.basicSalary, 0.5, AppColors.empPrimary, formatter),
              const SizedBox(height: 20),
              _breakdownItem('HRA', state.hra, 0.3, AppColors.empAccent, formatter),
              const SizedBox(height: 20),
              _breakdownItem('Allowances', state.allowances, 0.2, AppColors.accent, formatter),
            ],
          ),
        ),
      ],
    );
  }

  Widget _breakdownItem(String label, double value, double percent, Color color, NumberFormat formatter) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(formatter.format(value), style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent,
            backgroundColor: color.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentHistory(List<Map<String, dynamic>> history, NumberFormat formatter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Payment History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = history[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(LucideIcons.check, color: AppColors.success, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['month'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('Status: ${item['status']}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  Text(formatter.format(item['amount']), style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
