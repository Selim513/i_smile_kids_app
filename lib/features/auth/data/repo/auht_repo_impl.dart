import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_smile_kids_app/core/errors/auth_failure.dart';
import 'package:i_smile_kids_app/core/errors/firbease_auth_exceptions.dart';
import 'package:i_smile_kids_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:i_smile_kids_app/features/auth/data/repo/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AuthFailure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(handleFirebaseAuthException(e));
    } on Exception catch (e) {
      return Left(UnknownFailure('UnExpected Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(handleFirebaseAuthException(e));
    } on Exception catch (e) {
      return Left(UnknownFailure('UnExpected Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<AuthFailure, User?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(handleFirebaseAuthException(e));
    } on Exception catch (e) {
      return Left(UnknownFailure('UnExpected Error: ${e.toString()}'));
    }
  }

  // @override
  // Stream<User?> get authStateChanges {
  //   return remoteDataSource.authStateChanges;
  // }
}
