import 'package:hrm/shared/services/mock_data_service.dart';

class DashboardStats {
  final int totalEmployees;
  final int presentToday;
  final double totalMonthlySalary;
  final List<double> weeklyAttendance;

  DashboardStats({
    required this.totalEmployees,
    required this.presentToday,
    required this.totalMonthlySalary,
    required this.weeklyAttendance,
  });
}

abstract class DashboardRepository {
  Future<DashboardStats> getStats();
}

class HRDashboardRepository implements DashboardRepository {
  @override
  Future<DashboardStats> getStats() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final employees = MockDataService.employees;
    return DashboardStats(
      totalEmployees: employees.length,
      presentToday: employees.where((e) => e.isPresent).length,
      totalMonthlySalary: employees.fold(0.0, (sum, e) => sum + e.salary),
      weeklyAttendance: [0.8, 0.9, 0.75, 0.85, 0.92, 0.88, 0.0],
    );
  }
}
