import 'package:equatable/equatable.dart';

abstract class AuthFailure extends Equatable {
  final String message;
  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends AuthFailure {
  const ServerFailure(super.message);
}

class NetworkFailure extends AuthFailure {
  const NetworkFailure(super.message);
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure(super.message);
}

class UserNotFoundFailure extends AuthFailure {
  const UserNotFoundFailure(super.message);
}

class WrongPasswordFailure extends AuthFailure {
  const WrongPasswordFailure(super.message);
}

class UserDisabledFailure extends AuthFailure {
  const UserDisabledFailure(super.message);
}

class TooManyRequestsFailure extends AuthFailure {
  const TooManyRequestsFailure(super.message);
}

class UnknownFailure extends AuthFailure {
  const UnknownFailure(super.message);
}
