import 'package:get_it/get_it.dart';

// Repositories
import 'package:hrm/features/hr/dashboard/repository/dashboard_repository.dart';
import 'package:hrm/features/hr/employees/repository/employee_repository.dart';
import 'package:hrm/features/employee/attendance/repository/attendance_repository.dart';
import 'package:hrm/features/employee/salary/repository/salary_repository.dart';

// BLoCs
import 'package:hrm/features/hr/dashboard/bloc/dashboard_bloc.dart';
import 'package:hrm/features/hr/employees/bloc/staff_bloc.dart';
import 'package:hrm/features/employee/attendance/bloc/attendance_bloc.dart';
import 'package:hrm/features/employee/salary/bloc/payroll_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  // Repositories
  getIt.registerLazySingleton<DashboardRepository>(() => HRDashboardRepository());
  getIt.registerLazySingleton<EmployeeRepository>(() => HRManagementRepository());
  getIt.registerLazySingleton<AttendanceRepository>(() => UserAttendanceRepository());
  getIt.registerLazySingleton<SalaryRepository>(() => UserSalaryRepository());

  // BLoCs
  getIt.registerFactory(() => DashboardBloc(repository: getIt()));
  getIt.registerFactory(() => StaffBloc(repository: getIt()));
  getIt.registerFactory(() => AttendanceBloc(repository: getIt()));
  getIt.registerFactory(() => PayrollBloc(salaryRepository: getIt()));
}
