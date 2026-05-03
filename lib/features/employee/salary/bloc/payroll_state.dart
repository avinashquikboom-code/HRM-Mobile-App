import 'package:equatable/equatable.dart';

abstract class PayrollState extends Equatable {
  const PayrollState();

  @override
  List<Object?> get props => [];
}

class PayrollInitial extends PayrollState {}

class PayrollLoading extends PayrollState {}

class PayrollLoaded extends PayrollState {
  final double basicSalary;
  final double hra;
  final double allowances;
  final double deductions;
  final List<Map<String, dynamic>> history;

  const PayrollLoaded({
    required this.basicSalary,
    required this.hra,
    required this.allowances,
    required this.deductions,
    required this.history,
  });

  double get netSalary => basicSalary + hra + allowances - deductions;

  @override
  List<Object?> get props => [basicSalary, hra, allowances, deductions, history];
}

class PayrollError extends PayrollState {
  final String message;
  const PayrollError(this.message);

  @override
  List<Object?> get props => [message];
}
