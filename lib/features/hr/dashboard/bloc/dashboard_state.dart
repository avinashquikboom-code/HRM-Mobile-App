import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
  
  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final int totalEmployees;
  final int presentToday;
  final double totalMonthlySalary;
  final List<double> weeklyAttendance;

  const DashboardLoaded({
    required this.totalEmployees,
    required this.presentToday,
    required this.totalMonthlySalary,
    required this.weeklyAttendance,
  });

  @override
  List<Object> get props => [totalEmployees, presentToday, totalMonthlySalary, weeklyAttendance];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object> get props => [message];
}
