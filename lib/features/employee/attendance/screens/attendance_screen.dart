import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/widgets/core/glass_card.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/features/employee/attendance/bloc/attendance_bloc.dart';
import 'package:hrm/features/employee/attendance/bloc/attendance_event.dart';
import 'package:hrm/features/employee/attendance/bloc/attendance_state.dart';
import 'package:hrm/config/injection/dependency_injection.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<AttendanceBloc>()..add(const LoadAttendanceLogs('1')),
      child: const AttendanceView(),
    );
  }
}

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  String _currentTime = '';
  String _currentDate = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    if (!mounted) return;
    setState(() {
      _currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
      _currentDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    });
    Future.delayed(const Duration(seconds: 1), _updateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
          if (state is AttendanceLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AttendanceLoaded) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverSafeArea(
                  sliver: SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          _buildMainClockCard(),
                          const SizedBox(height: 40),
                          _buildCalendarView(),
                          const SizedBox(height: 24),
                          _buildLegend(),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  Widget _buildMainClockCard() {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  LucideIcons.calendar,
                  size: 14,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  _currentDate,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
                _currentTime,
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                  letterSpacing: -1,
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .shimmer(
                duration: 3.seconds,
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.mapPin,
                size: 16,
                color: AppColors.textSecondary.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 8),
              Text(
                'Cyber City, Gurgaon, India',
                style: TextStyle(
                  color: AppColors.textSecondary.withValues(alpha: 0.7),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildCalendarView() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.softShadow,
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: DateTime.now(),
        calendarFormat: CalendarFormat.month,
        availableCalendarFormats: const {CalendarFormat.month: 'Month'},
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, date, _) => _buildCalendarDay(date),
          todayBuilder: (context, date, _) =>
              _buildCalendarDay(date, isToday: true),
          outsideBuilder: (context, date, _) =>
              const SizedBox(), // Hide outside days
        ),
      ),
    ).animate().fadeIn(delay: 600.ms);
  }

  Widget _buildCalendarDay(DateTime date, {bool isToday = false}) {
    // Mock logic for attendance statuses based on dates
    Color? bgColor;
    Color? borderColor;
    String status = '';

    if (date.day % 7 == 0) {
      bgColor = AppColors.warning.withValues(alpha: 0.15);
      borderColor = AppColors.warning;
      status = 'Late';
    } else if (date.day % 11 == 0) {
      bgColor = AppColors.error.withValues(alpha: 0.15);
      borderColor = AppColors.error;
      status = 'Hol';
    } else if (date.day % 15 == 0) {
      bgColor = const Color(0xFF6366F1).withValues(alpha: 0.15);
      borderColor = const Color(0xFF6366F1);
      status = 'Half';
    } else if (date.weekday == DateTime.sunday ||
        date.weekday == DateTime.saturday) {
      bgColor = Colors.grey.withValues(alpha: 0.05);
      borderColor = Colors.transparent;
    } else {
      bgColor = AppColors.success.withValues(alpha: 0.1);
      borderColor = AppColors.success.withValues(alpha: 0.5);
    }

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isToday ? AppColors.primary : borderColor,
          width: isToday ? 2 : 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${date.day}',
              style: TextStyle(
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isToday ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
            if (status.isNotEmpty)
              Text(
                status,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: borderColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _legendItem('Present', AppColors.success),
          _legendItem('Late', AppColors.warning),
          _legendItem('Half Day', const Color(0xFF6366F1)),
          _legendItem('Holiday', AppColors.error),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms);
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
