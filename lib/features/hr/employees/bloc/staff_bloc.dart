import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/employee_repository.dart';
import 'staff_event.dart';
import 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  final EmployeeRepository repository;

  StaffBloc({required this.repository}) : super(StaffInitial()) {
    on<LoadStaffEvent>(_onLoadStaff);
    on<SearchStaffEvent>(_onSearchStaff);
  }

  Future<void> _onLoadStaff(LoadStaffEvent event, Emitter<StaffState> emit) async {
    emit(StaffLoading());
    try {
      final employees = await repository.getEmployees();
      emit(StaffLoaded(employees: employees, filteredEmployees: employees));
    } catch (e) {
      emit(const StaffError('Failed to load staff'));
    }
  }

  void _onSearchStaff(SearchStaffEvent event, Emitter<StaffState> emit) {
    if (state is StaffLoaded) {
      final currentState = state as StaffLoaded;
      final filtered = currentState.employees
          .where((e) => e.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(StaffLoaded(employees: currentState.employees, filteredEmployees: filtered));
    }
  }
}
