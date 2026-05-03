import 'package:equatable/equatable.dart';

abstract class StaffEvent extends Equatable {
  const StaffEvent();

  @override
  List<Object?> get props => [];
}

class LoadStaffEvent extends StaffEvent {}

class SearchStaffEvent extends StaffEvent {
  final String query;
  const SearchStaffEvent(this.query);

  @override
  List<Object?> get props => [query];
}
