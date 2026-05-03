import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/dashboard_repository.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;

  DashboardBloc({required this.repository}) : super(DashboardInitial()) {
    on<LoadDashboardEvent>(_onLoadDashboard);
  }

  Future<void> _onLoadDashboard(LoadDashboardEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    try {
      final stats = await repository.getStats();
      emit(DashboardLoaded(
        totalEmployees: stats.totalEmployees,
        presentToday: stats.presentToday,
        totalMonthlySalary: stats.totalMonthlySalary,
        weeklyAttendance: stats.weeklyAttendance,
      ));
    } catch (e) {
      emit(const DashboardError('Failed to load dashboard data'));
    }
  }
}
