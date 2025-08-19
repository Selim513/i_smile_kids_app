import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_smile_kids_app/core/services/service_locator.dart';

abstract class AuthRemoteDataSource {
  Future<User> login({required String email, required String password});
  Future<void> logout();
  Future<User?> getCurrentUser();
  // Stream<User?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  FirebaseAuth firebaseAuth = getIt.get<FirebaseAuth>();

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (credential.user == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'User not found',
        );
      }

      return credential.user!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      return firebaseAuth.currentUser;
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Stream<User?> get authStateChanges {
  //   return firebaseAuth.authStateChanges();
  // }
}
