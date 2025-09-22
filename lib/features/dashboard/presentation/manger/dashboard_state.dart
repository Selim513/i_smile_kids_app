import 'package:equatable/equatable.dart';
import 'package:i_smile_kids_app/features/dashboard/data/models/dashboard_appointment_model.dart';
import 'package:i_smile_kids_app/features/dashboard/data/models/docotr_user.dart';
import 'package:i_smile_kids_app/features/dashboard/data/models/redeemd_prize_model.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<DashboardAppointment> todayAppointments;
  final List<DashboardAppointment> allAppointment;
  final List<AllUsersModel> patients; // قائمة من نوع الموديل اللي اتفقنا عليه

  final PatientStatistics statistics;
  final DoctorUser? currentUser;

  DashboardLoaded({
    required this.patients,
    required this.allAppointment,
    required this.todayAppointments,
    required this.statistics,
    this.currentUser,
  });

  @override
  List<Object?> get props => [todayAppointments, statistics, currentUser];
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);

  @override
  List<Object> get props => [message];
}

class AppointmentUpdating extends DashboardState {}

class AppointmentUpdated extends DashboardState {
  final String message;

  AppointmentUpdated(this.message);

  @override
  List<Object> get props => [message];
}

// Reedemd prize
class DashboardPendingPrizesLoaded extends DashboardState {
  final List<RedeemedPrizeDetails> prizes;

  DashboardPendingPrizesLoaded({required this.prizes});
}
