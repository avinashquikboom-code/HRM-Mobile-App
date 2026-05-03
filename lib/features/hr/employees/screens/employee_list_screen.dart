import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/features/hr/employees/bloc/staff_bloc.dart';
import 'package:hrm/features/hr/employees/bloc/staff_event.dart';
import 'package:hrm/features/hr/employees/bloc/staff_state.dart';
import 'package:hrm/config/injection/dependency_injection.dart';
import 'package:hrm/shared/models/employee_model.dart';
import 'package:go_router/go_router.dart';
import 'package:hrm/config/routes/app_router.dart';


class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StaffBloc>()..add(LoadStaffEvent()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'My Staff',
            style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () => context.push(AppRouter.hrStaffFilter),
              icon: const Icon(LucideIcons.filter, color: AppColors.textPrimary),
            ),
            IconButton(
              onPressed: () => context.push(AppRouter.hrAddEmployee),
              icon: const Icon(LucideIcons.userPlus, color: AppColors.hrPrimary),
            ),
          ],
        ),
        body: Column(
          children: [
            _buildSearchBar(context),
            const SizedBox(height: 16),
            _buildCategoryTabs(),
            const SizedBox(height: 16),
            Expanded(child: _buildEmployeeListBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        onChanged: (query) {
          context.read<StaffBloc>().add(SearchStaffEvent(query));
        },
        decoration: InputDecoration(
          hintText: 'Search by name or role...',
          prefixIcon: const Icon(LucideIcons.search, size: 20),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ).animate().fadeIn().slideX(begin: -0.1, end: 0);
  }

  Widget _buildCategoryTabs() {
    final categories = ['All', 'Full-time', 'Part-time', 'Interns'];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isActive = index == 0;
          return Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isActive ? AppColors.hrPrimary : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isActive ? AppColors.hrPrimary : AppColors.textSecondary.withValues(alpha: 0.1)),
            ),
            child: Text(
              categories[index],
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          );
        },
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildEmployeeListBody() {
    return BlocBuilder<StaffBloc, StaffState>(
      builder: (context, state) {
        if (state is StaffLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is StaffLoaded) {
          return ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: state.filteredEmployees.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final employee = state.filteredEmployees[index];
              return _buildEmployeeCard(employee, index);
            },
          );
        }
        if (state is StaffError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('No staff found'));
      },
    );
  }

  Widget _buildEmployeeCard(Employee employee, int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColors.hrPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Center(
              child: Icon(LucideIcons.user, color: AppColors.hrPrimary),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary),
                ),
                Text(
                  '${employee.role} • ${employee.department}',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                ),
                const SizedBox(height: 8),
                _statusBadge(
                  employee.isPresent ? 'Present' : 'Absent',
                  employee.isPresent ? AppColors.success : AppColors.error,
                ),
              ],
            ),
          ),
          const Icon(LucideIcons.chevronRight, color: AppColors.textSecondary, size: 20),
        ],
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideY(begin: 0.1, end: 0);
  }

  Widget _statusBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
