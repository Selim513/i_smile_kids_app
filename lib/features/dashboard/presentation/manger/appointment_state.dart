import 'package:equatable/equatable.dart';
import 'package:i_smile_kids_app/features/dashboard/data/models/dashboard_appointment_model.dart';

abstract class AppointmentsListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppointmentsListInitial extends AppointmentsListState {}

class AppointmentsListLoading extends AppointmentsListState {}

class AppointmentsListLoaded extends AppointmentsListState {
  final List<DashboardAppointment> appointments;

  AppointmentsListLoaded(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class AppointmentsListError extends AppointmentsListState {
  final String message;

  AppointmentsListError(this.message);

  @override
  List<Object> get props => [message];
}
