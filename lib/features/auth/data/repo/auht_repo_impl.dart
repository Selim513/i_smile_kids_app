import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:i_smile_kids_app/core/errors/auth_failure.dart';
import 'package:i_smile_kids_app/core/errors/create_account_error_handle.dart';
import 'package:i_smile_kids_app/core/errors/firbease_auth_exceptions.dart';
import 'package:i_smile_kids_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:i_smile_kids_app/features/auth/data/models/create_account_model.dart';
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
  Future<Either<AuthFailure, User>> createAccount({
    required CreateAccountModel account,
  }) async {
    try {
      final validationError = validateCreateAccountRequest(account);
      if (validationError != null) {
        return Left(validationError);
      }
      final user = await remoteDataSource.createAccount(account: account);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(handleFirebaseAuthException(e));
    } on Exception catch (e) {
      return Left(UnknownFailure(' Failed to create account: ${e.toString()}'));
    }
  }

  @override
  Future<Either<AuthFailure, User>> signInWithGoogle() async {
    try {
      final user = await remoteDataSource.signInWithGoogle();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(handleFirebaseAuthException(e));
    } on Exception catch (e) {
      debugPrint('------------Google--${e.toString()}');
      return const Left(
        UnknownFailure('There is an error occured while sigin with google'),
      );
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

  @override
  Future<void> updateUserData({
    required String uid,
    required String name,
    required String age,
    required String nationality,
    required String emirateOfResidency,
    // File? photoURL,
  }) async {
    return await remoteDataSource.updateUserData(
      uid: uid,
      name: name,
      age: age,
      nationality: nationality,
      emirateOfResidency: emirateOfResidency,
      // pickedImage: photoURL,
    );
  }

  @override
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await remoteDataSource.sendPasswordResetEmail(email: email);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      debugPrint('-------------------------------------aa');
      return Left(handleFirebaseAuthException(e));
    } catch (e) {
      debugPrint('-------------------------------------ssss');

      return Left(UnknownFailure('Unexpected error: ${e.toString()}'));
    }
  }

  // @override
  // Stream<User?> get authStateChanges {
  //   return remoteDataSource.authStateChanges;
  // }
}
