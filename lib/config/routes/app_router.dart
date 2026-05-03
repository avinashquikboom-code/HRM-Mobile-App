import 'package:go_router/go_router.dart';
import 'package:hrm/features/auth/screens/splash_screen.dart';
import 'package:hrm/features/auth/screens/onboarding_screen.dart';
import 'package:hrm/features/auth/screens/login_screen.dart';
import 'package:hrm/features/auth/screens/forgot_password_screen.dart';

// HR Screens
import 'package:hrm/features/hr/dashboard/screens/hr_dashboard_screen.dart';
import 'package:hrm/features/hr/employees/screens/employee_list_screen.dart';
import 'package:hrm/features/hr/payroll/screens/hr_payroll_screen.dart';
import 'package:hrm/features/hr/attendance/screens/hr_attendance_screen.dart';
import 'package:hrm/features/hr/attendance/screens/attendance_policy_screen.dart';
import 'package:hrm/features/hr/reports/screens/hr_reports_screen.dart';
import 'package:hrm/features/hr/profile/screens/hr_profile_details_screens.dart';
import 'package:hrm/features/hr/profile/screens/settings_screens.dart';
import 'package:hrm/features/hr/profile/screens/security_details_screens.dart';
import 'package:hrm/features/hr/payroll/screens/run_payroll_screen.dart';
import 'package:hrm/features/hr/employees/screens/add_employee_screen.dart';
import 'package:hrm/features/hr/employees/screens/staff_filter_screen.dart';

// Employee Screens
import 'package:hrm/features/employee/dashboard/screens/employee_dashboard_screen.dart';
import 'package:hrm/features/employee/attendance/screens/attendance_screen.dart';
import 'package:hrm/features/employee/attendance/screens/attendance_rules_screen.dart';
import 'package:hrm/features/employee/salary/screens/payroll_screen.dart';
import 'package:hrm/features/employee/salary/screens/payroll_settings_screen.dart';
import 'package:hrm/features/employee/profile/screens/profile_screen.dart';
import 'package:hrm/features/employee/profile/screens/edit_profile_screen.dart';
import 'package:hrm/features/employee/leaves/screens/employee_leave_screen.dart';
import 'package:hrm/features/employee/leaves/screens/apply_leave_screen.dart';

// Shells
import 'package:hrm/widgets/core/hr_shell.dart';
import 'package:hrm/widgets/core/employee_shell.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';

  // HR Routes
  static const String hrDashboard = '/hr/dashboard';
  static const String hrEmployees = '/hr/employees';
  static const String hrPayroll = '/hr/payroll';
  static const String hrAttendance = '/hr/attendance';
  static const String hrReports = '/hr/reports';
  static const String hrProfile = '/hr/profile';
  static const String hrRunPayroll = '/hr/payroll/run';
  static const String hrAddEmployee = '/hr/employees/add';
  static const String hrStaffFilter = '/hr/employees/filter';
  static const String hrAttendancePolicy = '/hr/attendance/policy';

  // Employee Routes
  static const String empHome = '/emp/home';
  static const String empAttendance = '/emp/attendance';
  static const String empAttendanceRules = '/emp/attendance/rules';
  static const String empApplyLeave = '/emp/leave/apply';
  static const String empSalary = '/emp/salary';
  static const String empPayrollSettings = '/emp/salary/settings';
  static const String empLeave = '/emp/leave';
  static const String empProfile = '/emp/profile';

  // Profile Detail Routes
  static const String profileEdit = '/profile/edit';
  static const String profilePersonal = '/profile/personal';
  static const String profileSecurity = '/profile/security';
  static const String profileStructure = '/profile/structure';
  static const String profileNotifications = '/profile/notifications';
  static const String profilePolicies = '/profile/policies';

  // Security Sub-Routes
  static const String profileChangePassword = '/profile/security/password';
  static const String profileBiometric = '/profile/security/biometric';
  static const String profileTwoFactor = '/profile/security/2fa';
  static const String profileDevices = '/profile/security/devices';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: profileEdit,
        builder: (context, state) {
          final isHR = state.extra as bool? ?? false;
          return EditProfileScreen(isHR: isHR);
        },
      ),
      GoRoute(
        path: profilePersonal,
        builder: (context, state) => const PersonalInfoScreen(),
      ),
      GoRoute(
        path: profileSecurity,
        builder: (context, state) => const SecurityScreen(),
      ),
      GoRoute(
        path: profileStructure,
        builder: (context, state) => const CompanyStructureScreen(),
      ),
      GoRoute(
        path: profileNotifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: profilePolicies,
        builder: (context, state) => const CompanyPoliciesScreen(),
      ),
      GoRoute(
        path: profileChangePassword,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: profileBiometric,
        builder: (context, state) => const BiometricAuthScreen(),
      ),
      GoRoute(
        path: profileTwoFactor,
        builder: (context, state) => const TwoFactorAuthScreen(),
      ),
      GoRoute(
        path: profileDevices,
        builder: (context, state) => const ActiveDevicesScreen(),
      ),
      GoRoute(
        path: hrRunPayroll,
        builder: (context, state) => const RunPayrollScreen(),
      ),
      GoRoute(
        path: hrAddEmployee,
        builder: (context, state) => const AddEmployeeScreen(),
      ),
      GoRoute(
        path: hrStaffFilter,
        builder: (context, state) => const StaffFilterScreen(),
      ),
      GoRoute(
        path: hrAttendancePolicy,
        builder: (context, state) => const AttendancePolicyScreen(),
      ),
      GoRoute(
        path: empPayrollSettings,
        builder: (context, state) => const EmployeePayrollSettingsScreen(),
      ),
      GoRoute(
        path: empAttendanceRules,
        builder: (context, state) => const AttendanceRulesScreen(),
      ),
      GoRoute(
        path: empApplyLeave,
        builder: (context, state) => const ApplyLeaveScreen(),
      ),

      // HR App Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HRShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: hrDashboard,
                builder: (context, state) => const HRDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: hrEmployees,
                builder: (context, state) => const EmployeeListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: hrPayroll,
                builder: (context, state) => const HRPayrollScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: hrAttendance,
                builder: (context, state) => const HRAttendanceScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: hrReports,
                builder: (context, state) => const HRReportsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: hrProfile,
                builder: (context, state) => const ProfileScreen(isHR: true),
              ),
            ],
          ),
        ],
      ),

      // Employee App Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return EmployeeShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: empHome,
                builder: (context, state) => const EmployeeDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: empAttendance,
                builder: (context, state) => const AttendanceScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: empSalary,
                builder: (context, state) => const PayrollScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: empLeave,
                builder: (context, state) => const EmployeeLeaveScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: empProfile,
                builder: (context, state) => const ProfileScreen(isHR: false),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
