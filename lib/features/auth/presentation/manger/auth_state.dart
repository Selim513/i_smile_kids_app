import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthCubitState {}

class AuthCubitInitial extends AuthCubitState {}

//-Login sate

class AuthCubitLoginLoading extends AuthCubitState {}

class AuthCubitLoginSuccess extends AuthCubitState {
  final String succMessage;
  final User user;

  AuthCubitLoginSuccess({required this.user, required this.succMessage});
}

class AuthCubitLoginFailure extends AuthCubitState {
  final String errMessage;

  AuthCubitLoginFailure({required this.errMessage});
}

//- Create account state
class AuthCubitCreateAccountLoading extends AuthCubitState {}

class AuthCubitCreateAccountSuccess extends AuthCubitState {
  final String succMessage;

  AuthCubitCreateAccountSuccess({required this.succMessage});
}

class AuthCubitCreateAccountFailure extends AuthCubitState {
  final String errMessage;

  AuthCubitCreateAccountFailure({required this.errMessage});
}

//-Signin with google
class AuthCubitGoogleSigninLoading extends AuthCubitState {}

class AuthCubitGoogleSigninSuccess extends AuthCubitState {
  final String succMessage;

  AuthCubitGoogleSigninSuccess({required this.succMessage});
}

class AuthCubitGoogleSigninFailure extends AuthCubitState {
  final String errMessage;

  AuthCubitGoogleSigninFailure({required this.errMessage});
}

// Logout
class AuthCubitLogoutLoading extends AuthCubitState {}

class AuthCubitLogoutSuccess extends AuthCubitState {}

class AuthCubitLogoutFailure extends AuthCubitState {
  final String errMessage;

  AuthCubitLogoutFailure({required this.errMessage});
}

// Admin Login
class AuthCubitAdminLoginSuccess extends AuthCubitState {
  final String succMessage;

  AuthCubitAdminLoginSuccess({required this.succMessage});
}

//-Update user states
class AuthCubitUpdateUserFailure extends AuthCubitState {
  final String errMessage;

  AuthCubitUpdateUserFailure({required this.errMessage});
}

class AuthCubitUpdateUserDataLoading extends AuthCubitState {}

class AuthCubitUpdateUserSuccess extends AuthCubitState {
  final String succMessage;

  AuthCubitUpdateUserSuccess({required this.succMessage});
}

//-Reset Password
class AuthCubitResetPassowrdLoading extends AuthCubitState {}

class AuthCubitPasswordResetSuccess extends AuthCubitState {
  final String message;
  AuthCubitPasswordResetSuccess(this.message);
}

class AuthCubitPasswordResetFailure extends AuthCubitState {
  final String errMessage;
  AuthCubitPasswordResetFailure(this.errMessage);
}
