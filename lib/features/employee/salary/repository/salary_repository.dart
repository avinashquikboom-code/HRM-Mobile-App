import 'package:hrm/shared/models/employee_model.dart';
import 'package:hrm/shared/services/mock_data_service.dart';

abstract class SalaryRepository {
  Future<Employee?> getEmployeeSalaryInfo(String id);
}

class UserSalaryRepository implements SalaryRepository {
  @override
  Future<Employee?> getEmployeeSalaryInfo(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return MockDataService.employees.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}
