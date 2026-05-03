import 'package:equatable/equatable.dart';

abstract class PayrollEvent extends Equatable {
  const PayrollEvent();

  @override
  List<Object?> get props => [];
}

class LoadPayrollEvent extends PayrollEvent {
  final String employeeId;
  const LoadPayrollEvent(this.employeeId);

  @override
  List<Object?> get props => [employeeId];
}
