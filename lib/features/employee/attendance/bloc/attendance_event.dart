import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

class LoadAttendanceLogs extends AttendanceEvent {
  final String employeeId;
  const LoadAttendanceLogs(this.employeeId);

  @override
  List<Object?> get props => [employeeId];
}

class PunchInEvent extends AttendanceEvent {
  final String employeeId;
  final String location;
  const PunchInEvent(this.employeeId, this.location);

  @override
  List<Object?> get props => [employeeId, location];
}

class PunchOutEvent extends AttendanceEvent {
  final String employeeId;
  const PunchOutEvent(this.employeeId);

  @override
  List<Object?> get props => [employeeId];
}
