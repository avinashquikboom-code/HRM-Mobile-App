import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/attendance_repository.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository repository;

  AttendanceBloc({required this.repository}) : super(AttendanceInitial()) {
    on<LoadAttendanceLogs>(_onLoadLogs);
    on<PunchInEvent>(_onPunchIn);
    on<PunchOutEvent>(_onPunchOut);
  }

  Future<void> _onLoadLogs(LoadAttendanceLogs event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      final logs = await repository.getAttendanceLogs();
      emit(AttendanceLoaded(logs: logs, isPunchedIn: false));
    } catch (e) {
      emit(const AttendanceError('Failed to load logs'));
    }
  }

  Future<void> _onPunchIn(PunchInEvent event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      await repository.punchIn();
      final logs = await repository.getAttendanceLogs();
      emit(AttendanceLoaded(logs: logs, isPunchedIn: true));
    } catch (e) {
      emit(const AttendanceError('Punch in failed'));
    }
  }

  Future<void> _onPunchOut(PunchOutEvent event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      await repository.punchOut();
      final logs = await repository.getAttendanceLogs();
      emit(AttendanceLoaded(logs: logs, isPunchedIn: false));
    } catch (e) {
      emit(const AttendanceError('Punch out failed'));
    }
  }
}
