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
/*
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  const LoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);

  @override
  List<Object> get props => [message];
}
*/