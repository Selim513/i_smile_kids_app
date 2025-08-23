import 'package:i_smile_kids_app/core/models/user_models.dart';

abstract class FetchProfileDataCubitState {}

class FetchProfileDataInitial extends FetchProfileDataCubitState {}

class FetchProfileDataSuccess extends FetchProfileDataCubitState {
  final UserModel userData;

  FetchProfileDataSuccess({required this.userData});
}

class FetchProfileDataFailure extends FetchProfileDataCubitState {
  final String errMessage;
  FetchProfileDataFailure({required this.errMessage});
}

class FetchProfileDataLoading extends FetchProfileDataCubitState {}

class UpdateProfileLoading extends FetchProfileDataCubitState {}

class UpdateProfileSuccess extends FetchProfileDataCubitState {
  final UserModel userData;
  UpdateProfileSuccess({required this.userData});
}

class UpdateProfileFailure extends FetchProfileDataCubitState {
  final String errMessage;
  UpdateProfileFailure({required this.errMessage});
}
