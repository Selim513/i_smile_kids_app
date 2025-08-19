import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_smile_kids_app/core/services/upload_image_helper.dart';
import 'package:i_smile_kids_app/core/services/save_user_data_to_firestore.dart';
import 'package:i_smile_kids_app/core/services/service_locator.dart';
import 'package:i_smile_kids_app/features/auth/data/models/create_account_model.dart';

abstract class AuthRemoteDataSource {
  Future<User> login({required String email, required String password});
  Future<User> createAccount({required CreateAccountModel account});

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
  Future<User> createAccount({required CreateAccountModel account}) async {
    try {
      // Create account with Firebase Auth
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: account.email.trim(),
        password: account.password,
      );

      if (credential.user == null) {
        throw FirebaseAuthException(
          code: 'user-creation-failed',
          message: 'Create account failed',
        );
      }

      final user = credential.user!;
      String? photoURL;

      // Upload profile image if provided
      if (account.profileImage != null) {
        photoURL = await uploadProfileImage(user.uid, account.profileImage!);
      }

      // Update user profile
      await user.updateDisplayName(account.name);
      if (photoURL != null) {
        await user.updatePhotoURL(photoURL);
      }

      // Save additional user data to Firestore
      await saveUserDataToFirestore(
        age:account.age ,
        uid: user.uid,
        name: account.name,
        email: account.email,
        nationality: account.nationality,
        emirateOfResidency: account.emirateOfResidency,
        photoURL: photoURL,

      );

      // Reload user to get updated data
      await user.reload();
      return firebaseAuth.currentUser!;
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
