import 'package:hrm/shared/models/employee_model.dart';
import 'package:hrm/shared/models/attendance_model.dart';

class MockDataService {
  static final List<Employee> employees = [
    Employee(
      id: '1',
      name: 'Avinash Magar',
      role: 'Mobile Lead',
      department: 'Engineering',
      salary: 85000,
      isPresent: true,
      imageUrl: 'https://api.dicebear.com/7.x/avataaars/png?seed=Avinash',
    ),
    Employee(
      id: '2',
      name: 'Rahul Kumar',
      role: 'UI Designer',
      department: 'Design',
      salary: 65000,
      isPresent: false,
      imageUrl: 'https://api.dicebear.com/7.x/avataaars/png?seed=Rahul',
    ),
    Employee(
      id: '3',
      name: 'Priya Singh',
      role: 'HR Manager',
      department: 'HR',
      salary: 75000,
      isPresent: true,
      imageUrl: 'https://api.dicebear.com/7.x/avataaars/png?seed=Priya',
    ),
    Employee(
      id: '4',
      name: 'Amit Shah',
      role: 'Backend Developer',
      department: 'Engineering',
      salary: 70000,
      isPresent: true,
      imageUrl: 'https://api.dicebear.com/7.x/avataaars/png?seed=Amit',
    ),
  ];

  static final List<AttendanceRecord> attendanceLogs = [
    AttendanceRecord(date: DateTime(2024, 5, 15), punchIn: '09:30 AM', punchOut: '06:30 PM', status: 'Present'),
    AttendanceRecord(date: DateTime(2024, 5, 14), punchIn: '09:45 AM', punchOut: '06:15 PM', status: 'Present'),
    AttendanceRecord(date: DateTime(2024, 5, 13), punchIn: '09:15 AM', punchOut: '07:00 PM', status: 'Present'),
  ];
}
