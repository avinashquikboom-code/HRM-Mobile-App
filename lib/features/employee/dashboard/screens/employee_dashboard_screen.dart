import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/config/routes/app_router.dart';
import 'package:hrm/features/employee/attendance/bloc/attendance_bloc.dart';
import 'package:hrm/features/employee/attendance/bloc/attendance_event.dart';
import 'package:hrm/features/employee/attendance/bloc/attendance_state.dart';
import 'package:hrm/config/injection/dependency_injection.dart';
import 'package:hrm/widgets/core/glass_card.dart';

class EmployeeDashboardScreen extends StatelessWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AttendanceBloc>()..add(const LoadAttendanceLogs('1')),
      child: const EmployeeDashboardView(),
    );
  }
}

class EmployeeDashboardView extends StatefulWidget {
  const EmployeeDashboardView({super.key});

  @override
  State<EmployeeDashboardView> createState() => _EmployeeDashboardViewState();
}

class _EmployeeDashboardViewState extends State<EmployeeDashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPunchCard(context, state),
                      const SizedBox(height: 24),
                      _buildQuickActions(context),
                      const SizedBox(height: 24),
                      _buildSalaryOverview(),
                      const SizedBox(height: 32),
                      _buildSectionTitle('Recent Attendance'),
                      const SizedBox(height: 16),
                      _buildAttendanceHistory(state),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: AppColors.background,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello, Rahul!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                DateFormat('EEEE, d MMM').format(DateTime.now()),
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ],
          ),
          InkWell(
            onTap: () => context.go(AppRouter.empProfile),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2), 
                  width: 2,
                ),
              ),
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(
                  'assets/images/emp_avatar.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPunchCard(BuildContext context, AttendanceState state) {
    final isPunchedIn = state is AttendanceLoaded ? state.isPunchedIn : false;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (isPunchedIn ? AppColors.success : AppColors.textSecondary).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPunchedIn ? LucideIcons.userCheck : LucideIcons.userX,
                  color: isPunchedIn ? AppColors.success : AppColors.textSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isPunchedIn ? 'Working Now' : 'Not Punched In',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    isPunchedIn ? 'Stay focused!' : 'Start your day!',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              if (isPunchedIn)
                const Text(
                  '08:42:15',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 32),
          GestureDetector(
            onTap: () {
              if (isPunchedIn) {
                context.read<AttendanceBloc>().add(const PunchOutEvent('1'));
              } else {
                context.read<AttendanceBloc>().add(const PunchInEvent('1', 'Cyber City, Gurgaon'));
              }
            },
            child: Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isPunchedIn 
                  ? const LinearGradient(colors: [AppColors.error, Color(0xFFFF6B6B)]) 
                  : AppColors.empGradient,
                boxShadow: [
                  BoxShadow(
                    color: (isPunchedIn ? AppColors.error : AppColors.primary).withValues(alpha: 0.3),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isPunchedIn ? LucideIcons.logOut : LucideIcons.fingerprint,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isPunchedIn ? 'PUNCH OUT' : 'PUNCH IN',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true))
             .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 2.seconds),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _punchStat('Check In', '09:30 AM', LucideIcons.clock),
              Container(height: 24, width: 1, color: Colors.black12),
              _punchStat('Location', 'Gurgaon', LucideIcons.mapPin),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  Widget _punchStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _quickAction(context, 'Attendance', LucideIcons.calendarCheck, AppColors.primary, () => context.go(AppRouter.empAttendance)),
        _quickAction(context, 'Leave', LucideIcons.calendar, const Color(0xFF6366F1), () => context.go(AppRouter.empLeave)),
        _quickAction(context, 'Salary', LucideIcons.banknote, const Color(0xFFF59E0B), () => context.go(AppRouter.empSalary)),
        _quickAction(context, 'Policy', LucideIcons.fileText, const Color(0xFF10B981), () => context.go(AppRouter.empAttendanceRules)),
      ],
    );
  }

  Widget _quickAction(BuildContext context, String label, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildSalaryOverview() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('May Earnings', style: TextStyle(color: Colors.white70, fontSize: 14)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('PAID', style: TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '₹52,400.00',
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _miniBadge(LucideIcons.calendar, '22 Days'),
              const SizedBox(width: 12),
              _miniBadge(LucideIcons.clock, '4h OT'),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).scale();
  }

  Widget _miniBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 14),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
    );
  }

  Widget _buildAttendanceHistory(AttendanceState state) {
    if (state is! AttendanceLoaded) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final log = state.logs[index];
        return GlassCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(LucideIcons.clock, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEE, d MMM').format(log.date),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'In: ${log.punchIn} • Out: ${log.punchOut ?? '--'}',
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  log.status,
                  style: const TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    ).animate().fadeIn(delay: 600.ms);
  }
}
