import 'package:equatable/equatable.dart';
import 'package:hrm/shared/models/employee_model.dart';

abstract class StaffState extends Equatable {
  const StaffState();

  @override
  List<Object?> get props => [];
}

class StaffInitial extends StaffState {}

class StaffLoading extends StaffState {}

class StaffLoaded extends StaffState {
  final List<Employee> employees;
  final List<Employee> filteredEmployees;

  const StaffLoaded({required this.employees, required this.filteredEmployees});

  @override
  List<Object?> get props => [employees, filteredEmployees];
}

class StaffError extends StaffState {
  final String message;
  const StaffError(this.message);

  @override
  List<Object?> get props => [message];
}
