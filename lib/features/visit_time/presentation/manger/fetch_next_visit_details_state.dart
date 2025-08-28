import 'package:i_smile_kids_app/features/visit_time/data/models/patient_next_visit_model.dart';

class FetchNextVisitDetailsCubitState {}

class FetchNextVisitDetailsInital extends FetchNextVisitDetailsCubitState {}

class FetchNextVisitDetailsSuccess extends FetchNextVisitDetailsCubitState {
  final PatientNextVisit data;

  FetchNextVisitDetailsSuccess({required this.data});
}

class FetchNextVisitDetailsFailure extends FetchNextVisitDetailsCubitState {
  final String errMessage;

  FetchNextVisitDetailsFailure({required this.errMessage});
}

class FetchNextVisitDetailsLoading extends FetchNextVisitDetailsCubitState {}

class AppointmentCanncle extends FetchNextVisitDetailsCubitState {}
