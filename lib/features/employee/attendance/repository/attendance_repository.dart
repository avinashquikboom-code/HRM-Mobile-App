import 'package:hrm/shared/models/attendance_model.dart';
import 'package:hrm/shared/services/mock_data_service.dart';

abstract class AttendanceRepository {
  Future<List<AttendanceRecord>> getAttendanceLogs();
  Future<void> punchIn();
  Future<void> punchOut();
}

class UserAttendanceRepository implements AttendanceRepository {
  @override
  Future<List<AttendanceRecord>> getAttendanceLogs() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockDataService.attendanceLogs;
  }

  @override
  Future<void> punchIn() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> punchOut() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
