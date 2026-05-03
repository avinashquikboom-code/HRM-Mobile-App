import 'package:equatable/equatable.dart';
import 'package:hrm/shared/models/attendance_model.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<AttendanceRecord> logs;
  final bool isPunchedIn;

  const AttendanceLoaded({required this.logs, required this.isPunchedIn});

  @override
  List<Object?> get props => [logs, isPunchedIn];
}

class AttendanceError extends AttendanceState {
  final String message;
  const AttendanceError(this.message);

  @override
  List<Object?> get props => [message];
}
