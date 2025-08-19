abstract class AuthCubitState {}

class AuthCubitInitial extends AuthCubitState {}

class AuthCubiLoading extends AuthCubitState {}
//-Login sate

class AuthCubitLoginSuccess extends AuthCubitState {
  final String succMessage;

  AuthCubitLoginSuccess({required this.succMessage});
}

class AuthCubitLoginFailure extends AuthCubitState {
  final String errMessage;

  AuthCubitLoginFailure({required this.errMessage});
}

//- Create account state
class AuthCubitCreateAccountSuccess extends AuthCubitState {
  final String succMessage;

  AuthCubitCreateAccountSuccess({required this.succMessage});
}

class AuthCubitCreateAccountFailure extends AuthCubitState {
  final String errMessage;

  AuthCubitCreateAccountFailure({required this.errMessage});
}
//-image
class AuthCubitPickImageSuccess extends AuthCubitState {
  final String imagePath;
  AuthCubitPickImageSuccess(this.imagePath);
}

class AuthCubitPickImageFailure extends AuthCubitState {
  final String errMessage;
  AuthCubitPickImageFailure(this.errMessage);
}