import 'package:i_smile_kids_app/features/book_appointment/data/models/doctors_model.dart';

abstract class FetchDoctorsDataState {}

class FetchDoctorsDataInitial extends FetchDoctorsDataState {}

class FetchDoctorsDataLoading extends FetchDoctorsDataState {}

class FetchDoctorsDataSuccess extends FetchDoctorsDataState {
  final List<DoctorsModel> data;

  FetchDoctorsDataSuccess({required this.data});
}

class FetchDoctorsDataFailure extends FetchDoctorsDataState {
  final String errMessage;

  FetchDoctorsDataFailure({required this.errMessage});
}
