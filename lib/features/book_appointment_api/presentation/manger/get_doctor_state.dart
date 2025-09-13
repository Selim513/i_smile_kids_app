import 'package:i_smile_kids_app/core/api/models/doctors_list_model/doctor.dart';

abstract class GetDoctorState {}

class GetDoctorInitial extends GetDoctorState {}

class GetDoctorSuccess extends GetDoctorState {
  final List<Doctor> doctorList;

  GetDoctorSuccess({required this.doctorList});
}

class GetDoctorFailure extends GetDoctorState {
  final String errMessage;

  GetDoctorFailure({required this.errMessage});
}

class GetDoctorLoading extends GetDoctorState {}
