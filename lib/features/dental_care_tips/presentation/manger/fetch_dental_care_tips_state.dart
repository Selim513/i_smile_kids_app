import 'package:i_smile_kids_app/features/dental_care_tips/data/models/dental_care_tips_model/dental_care_tips_model.dart';

abstract class FetchDentalCareTipsState {}

class FetchDentalCareTipsInitial extends FetchDentalCareTipsState {}

class FetchDentalCareTipsSuccess extends FetchDentalCareTipsState {
  final List<DentalCareTipsModel> tips;

  FetchDentalCareTipsSuccess({required this.tips});
}

class FetchDentalCareTipsFailure extends FetchDentalCareTipsState {
  final String errMessage;

  FetchDentalCareTipsFailure({required this.errMessage});
}

class FetchDentalCareTipsLoading extends FetchDentalCareTipsState {}
