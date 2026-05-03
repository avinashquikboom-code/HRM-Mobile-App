import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/widgets/core/glass_card.dart';
import 'package:hrm/widgets/core/gradient_button.dart';

class StaffFilterScreen extends StatefulWidget {
  const StaffFilterScreen({super.key});

  @override
  State<StaffFilterScreen> createState() => _StaffFilterScreenState();
}

class _StaffFilterScreenState extends State<StaffFilterScreen> {
  String _selectedDept = 'All';
  String _selectedType = 'Full-time';
  RangeValues _salaryRange = const RangeValues(20000, 150000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Filter Staff', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Reset', style: TextStyle(color: AppColors.hrPrimary, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(LucideIcons.building, 'Department'),
                  const SizedBox(height: 16),
                  _buildDeptGrid(),
                  const SizedBox(height: 32),
                  _buildSectionHeader(LucideIcons.briefcase, 'Employment Type'),
                  const SizedBox(height: 16),
                  _buildTypeSelector(),
                  const SizedBox(height: 32),
                  _buildSectionHeader(LucideIcons.banknote, 'Salary Range (Monthly)'),
                  const SizedBox(height: 32),
                  _buildSalarySlider(),
                  const SizedBox(height: 32),
                  _buildSectionHeader(LucideIcons.calendar, 'Joining Period'),
                  const SizedBox(height: 16),
                  _buildDateFilter(),
                ].animate(interval: 50.ms).fadeIn().slideY(begin: 0.1, end: 0),
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.hrPrimary),
        const SizedBox(width: 12),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildDeptGrid() {
    final depts = ['All', 'Engineering', 'Design', 'HR', 'Sales', 'Product', 'Legal', 'Support'];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: depts.map((dept) {
        bool isSelected = _selectedDept == dept;
        return InkWell(
          onTap: () => setState(() => _selectedDept = dept),
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: 200.ms,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.hrPrimary : AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isSelected ? [BoxShadow(color: AppColors.hrPrimary.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4))] : AppColors.softShadow,
              border: Border.all(color: isSelected ? AppColors.hrPrimary : Colors.transparent),
            ),
            child: Text(
              dept,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTypeSelector() {
    final types = ['Full-time', 'Contract', 'Intern', 'Freelance'];
    return Row(
      children: types.map((type) {
        bool isSelected = _selectedType == type;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedType = type),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.hrPrimary.withValues(alpha: 0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isSelected ? AppColors.hrPrimary : AppColors.textSecondary.withValues(alpha: 0.1)),
              ),
              child: Text(
                type,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.hrPrimary : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSalarySlider() {
    return Column(
      children: [
        RangeSlider(
          values: _salaryRange,
          min: 10000,
          max: 300000,
          activeColor: AppColors.hrPrimary,
          inactiveColor: AppColors.surface,
          labels: RangeLabels('₹${_salaryRange.start.round()}', '₹${_salaryRange.end.round()}'),
          onChanged: (v) => setState(() => _salaryRange = v),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('₹${(_salaryRange.start / 1000).toStringAsFixed(0)}k', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              Text('₹${(_salaryRange.end / 1000).toStringAsFixed(0)}k+', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateFilter() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Custom Range', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text('Jan 2024 - Dec 2024', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
          IconButton(
            icon: const Icon(LucideIcons.calendarRange, color: AppColors.hrPrimary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, -10))],
      ),
      child: GradientButton(
        text: 'Apply Filters',
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
