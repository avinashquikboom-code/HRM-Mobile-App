import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/salary_repository.dart';
import 'payroll_event.dart';
import 'payroll_state.dart';

class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  final SalaryRepository salaryRepository;

  PayrollBloc({required this.salaryRepository}) : super(PayrollInitial()) {
    on<LoadPayrollEvent>(_onLoadPayroll);
  }

  Future<void> _onLoadPayroll(
    LoadPayrollEvent event,
    Emitter<PayrollState> emit,
  ) async {
    emit(PayrollLoading());
    try {
      final employee = await salaryRepository.getEmployeeSalaryInfo(
        event.employeeId,
      );
      if (employee == null) {
        emit(const PayrollError('Employee not found'));
        return;
      }

      final basic = employee.salary * 0.5;
      final hra = employee.salary * 0.3;
      final allowances = employee.salary * 0.2;
      final deductions = employee.salary * 0.1;

      final history = [
        {'month': 'April 2024', 'amount': employee.salary, 'status': 'Paid'},
        {'month': 'March 2024', 'amount': employee.salary, 'status': 'Paid'},
        {'month': 'February 2024', 'amount': employee.salary, 'status': 'Paid'},
      ];

      emit(
        PayrollLoaded(
          basicSalary: basic,
          hra: hra,
          allowances: allowances,
          deductions: deductions,
          history: history,
        ),
      );
    } catch (e) {
      emit(const PayrollError('Failed to load payroll data'));
    }
  }
}
