import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_smile_kids_app/core/services/firebase_firestore_data_helper.dart';
import 'package:i_smile_kids_app/core/services/service_locator.dart';
import 'package:i_smile_kids_app/features/auth/data/models/create_account_model.dart';

abstract class AuthRemoteDataSource {
  Future<User> login({required String email, required String password});
  Future<User> createAccount({required CreateAccountModel account});
  Future<User> signInWithGoogle();
  Future<void> sendPasswordResetEmail({required String email});

  Future<void> updateUserData({
    required String uid,
    required String name,
    required String age,
    // required String nationality,
    // required String emirateOfResidency,
    // File? pickedImage,
  });

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

      await user.updateDisplayName(account.name);

      await saveUserDataToFirestore(
        signinMethod: 'Email Address',
        age: account.age,
        uid: user.uid,
        name: account.name,
        email: account.email,
        // nationality: account.nationality,
        // emirateOfResidency: account.emirateOfResidency,
        point: 0,
      );

      // Reload user to get updated data
      await user.reload();
      return firebaseAuth.currentUser!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn.instance;

    try {
      // googleSignIn.initialize();
      await googleSignIn.initialize(
        clientId:
            '69735136717-hqpib3aedst13af06kpsq5aapgvgfe6q.apps.googleusercontent.com',
        // serverClientId:
        //     '69735136717-pak3o49r3dcsuq137ibkb09hv455rcr5.apps.googleusercontent.com',
      );
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      if (googleUser.authentication.idToken == null) {
        throw FirebaseAuthException(
          code: 'sign-in-cancelled',
          message: 'Google sign-in was cancelled by the user.',
        );
      }
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      if (userCredential.user == null) {
        throw FirebaseAuthException(
          code: 'sign_in_failed',
          message: 'Failed to singin with Google.',
        );
      }
      final user = userCredential.user!;
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        await saveUserDataToFirestore(
          age: '',
          uid: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          // nationality: '',
          // emirateOfResidency: '',
          photoURL: user.photoURL,
          signinMethod: 'google',
        );
      }
      return user;
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

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException {
      rethrow; // repo سيتعامل مع الـ FirebaseAuthException
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUserData({
    required String uid,
    required String name,
    required String age,
    // required String nationality,
    // required String emirateOfResidency,
  }) async {
    try {
      final user = firebaseAuth.currentUser;

      if (user == null) {
        throw FirebaseAuthException(
          code: 'no-current-user',
          message: 'No user is currently signed in.',
        );
      }

      // تحديث الـ displayName
      if (name.isNotEmpty) {
        await user.updateDisplayName(name);
      }

      // حفظ البيانات المحدثة في Firestore
      await updateUserDetails(
        uid: uid,
        age: age,
        // nationality: nationality,
        // emirateOfResidency: emirateOfResidency,
      );

      await user.reload();
    } catch (e) {
      rethrow;
    }
  }
}
