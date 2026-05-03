import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:hrm/core/constants/app_colors.dart';
import 'package:hrm/config/routes/app_router.dart';
import 'package:hrm/widgets/core/glass_card.dart';

class ProfileScreen extends StatelessWidget {
  final bool isHR;
  
  const ProfileScreen({
    super.key,
    this.isHR = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildProfileStats(),
                  const SizedBox(height: 32),
                  _buildMenuSection('Account Settings', [
                    _menuItem(context, LucideIcons.user, 'Personal Information', 'Name, Email, Phone', onTap: () => context.push(AppRouter.profilePersonal)),
                    _menuItem(context, LucideIcons.shield, 'Security', 'Password, 2FA, Biometrics', onTap: () => context.push(AppRouter.profileSecurity)),
                    _menuItem(context, LucideIcons.bell, 'Notifications', 'Alerts, Emails, Push', onTap: () => context.push(AppRouter.profileNotifications)),
                  ]),
                  const SizedBox(height: 24),
                  _buildMenuSection(isHR ? 'HR Administration' : 'HR Ecosystem', [
                    if (isHR) ...[
                      _menuItem(context, LucideIcons.users, 'Staff Management', 'Add, Edit, Remove Employees', onTap: () => context.push(AppRouter.hrEmployees)),
                      _menuItem(context, LucideIcons.briefcase, 'Company Structure', 'Departments, Designations', onTap: () => context.push(AppRouter.profileStructure)),
                    ],
                    _menuItem(context, LucideIcons.wallet, isHR ? 'Global Payroll' : 'Payroll Settings', isHR ? 'Cycles, Rates, Taxes' : 'Bank Account, Tax Info', onTap: () => context.push(isHR ? AppRouter.hrPayroll : AppRouter.empPayrollSettings)),
                    _menuItem(context, LucideIcons.calendar, isHR ? 'Attendance Policy' : 'Attendance Rules', isHR ? 'Late Rules, Holiday List' : 'Work Hours, Holiday List', onTap: () => context.push(isHR ? AppRouter.hrAttendancePolicy : AppRouter.empAttendanceRules)),
                    _menuItem(context, LucideIcons.fileText, 'Company Policies', 'Leave Policy, Conduct', onTap: () => context.push(AppRouter.profilePolicies)),
                  ]),
                  const SizedBox(height: 32),
                  _buildLogoutButton(context),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: isHR ? AppColors.hrPrimary : AppColors.primary,
      // Removed the edit button from actions so it can scroll with the header
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: isHR ? AppColors.hrGradient : AppColors.empGradient,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          isHR 
                            ? 'assets/images/hr_avatar.png'
                            : 'assets/images/emp_avatar.png'
                        ),
                      ),
                    ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                    
                    // Edit Icon that scrolls with the avatar
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => context.push(AppRouter.profileEdit, extra: isHR),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Icon(
                            LucideIcons.edit2, 
                            color: isHR ? AppColors.hrPrimary : AppColors.primary, 
                            size: 18
                          ),
                        ),
                      ).animate().scale(delay: 400.ms, duration: 400.ms, curve: Curves.bounceOut),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  isHR ? 'Priya Singh' : 'Rahul Kumar',
                  style: const TextStyle(
                    color: Colors.white, 
                    fontSize: 26, 
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ).animate().fadeIn(delay: 200.ms),
                Text(
                  isHR ? 'HR Manager • HRM' : 'UI Designer • HRM',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8), 
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fadeIn(delay: 300.ms),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStats() {
    return Row(
      children: [
        Expanded(child: _statBox('Joining', 'Jan 2022')),
        const SizedBox(width: 12),
        Expanded(child: _statBox('Dept', isHR ? 'Human Resource' : 'Design')),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _statBox(String label, String value) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 16),
        GlassCard(
          padding: EdgeInsets.zero,
          child: Column(children: items),
        ),
      ],
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _menuItem(BuildContext context, IconData icon, String title, String subtitle, {VoidCallback? onTap}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (isHR ? AppColors.hrPrimary : AppColors.primary).withValues(alpha: 0.1), 
          borderRadius: BorderRadius.circular(10)
        ),
        child: Icon(icon, color: isHR ? AppColors.hrPrimary : AppColors.primary, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      trailing: const Icon(LucideIcons.chevronRight, size: 16, color: AppColors.textSecondary),
      onTap: onTap ?? () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening $title...'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: isHR ? AppColors.hrPrimary : AppColors.primary,
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 64, color: Colors.black12),
        InkWell(
          onTap: () => _showLogoutDialog(context),
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.error.withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    LucideIcons.logOut, 
                    color: AppColors.error, 
                    size: 22,
                  ),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Logout from Account',
                        style: TextStyle(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Sign out of your session safely',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  LucideIcons.chevronRight, 
                  color: AppColors.error, 
                  size: 20,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2, end: 0);
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.65),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 32),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A2236), Color(0xFF0F1624)],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.45),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Glowing red icon
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFF4B4B).withValues(alpha: 0.12),
                    border: Border.all(
                      color: const Color(0xFFFF4B4B).withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF4B4B).withValues(alpha: 0.2),
                        blurRadius: 24,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    LucideIcons.logOut,
                    color: Color(0xFFFF4B4B),
                    size: 32,
                  ),
                ),
                const SizedBox(height: 22),

                // Title
                const Text(
                  'Sign Out?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 10),

                // Subtitle
                Text(
                  "You'll need to log in again\nto access your dashboard.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.45),
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 28),

                // Sign Out button — full width, red gradient
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.login);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF4B4B), Color(0xFFD93636)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF4B4B).withValues(alpha: 0.38),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LucideIcons.logOut, color: Colors.white, size: 17),
                        SizedBox(width: 8),
                        Text(
                          'Yes, Sign Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Cancel button — ghost style
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white.withValues(alpha: 0.05),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white60,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

