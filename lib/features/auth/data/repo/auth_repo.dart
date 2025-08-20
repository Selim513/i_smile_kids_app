import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_smile_kids_app/core/errors/auth_failure.dart';
import 'package:i_smile_kids_app/features/auth/data/models/create_account_model.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, User>> login({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure, User>> createAccount({
    required CreateAccountModel account
  });
    Future<Either<AuthFailure, User>> signInWithGoogle();


  Future<Either<AuthFailure, Unit>> logout();

  Future<Either<AuthFailure, User?>> getCurrentUser();

  // Stream<User?> get authStateChanges;
}
