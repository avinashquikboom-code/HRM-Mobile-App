import 'package:hrm/shared/models/employee_model.dart';
import 'package:hrm/shared/services/mock_data_service.dart';

abstract class EmployeeRepository {
  Future<List<Employee>> getEmployees();
  Future<Employee?> getEmployeeById(String id);
}

class HRManagementRepository implements EmployeeRepository {
  @override
  Future<List<Employee>> getEmployees() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockDataService.employees;
  }

  @override
  Future<Employee?> getEmployeeById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockDataService.employees.firstWhere((e) => e.id == id);
  }
}
