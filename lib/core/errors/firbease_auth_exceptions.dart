// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:i_smile_kids_app/core/errors/auth_failure.dart';

// AuthFailure handleFirebaseAuthException(FirebaseAuthException e) {
//   switch (e.code) {
//     case 'user-not-found':
//       return const UserNotFoundFailure('User not found');
//     case 'wrong-password':
//       return const WrongPasswordFailure('Wrong password');
//     case 'invalid-email':
//       return const InvalidCredentialsFailure('Invalid email');
//     case 'user-disabled':
//       return const UserDisabledFailure('This account has been disabled');
//     case 'too-many-requests':
//       return const TooManyRequestsFailure('Too many attempts, try again later');
//     case 'invalid-credential':
//       return const InvalidCredentialsFailure('Invalid login credentials');
//     case 'network-request-failed':
//       return const NetworkFailure('Check your internet connection');
//     case 'weak-password':
//       return const InvalidCredentialsFailure('Weak password');
//     case 'email-already-in-use':
//       return const InvalidCredentialsFailure('Email is already in use');
//     default:
//       return ServerFailure(
//         'An error occurred: ${e.message ?? 'Unknown error'}',
//       );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_smile_kids_app/core/errors/auth_failure.dart';

AuthFailure handleFirebaseAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'user-not-found':
      return const UserNotFoundFailure(
        'No account found with this email. Please sign up.',
      );
    case 'wrong-password':
      return const WrongPasswordFailure(
        'Incorrect password. Please try again.',
      );
    case 'invalid-email':
      return const InvalidCredentialsFailure('The email address is not valid.');
    case 'user-disabled':
      return const UserDisabledFailure(
        'This account has been disabled. Contact support for help.',
      );
    case 'too-many-requests':
      return const TooManyRequestsFailure(
        'Too many attempts. Please wait and try again later.',
      );
    case 'invalid-credential':
      return const InvalidCredentialsFailure('Email or password is incorrect');
    case 'network-request-failed':
      return const NetworkFailure(
        'No internet connection. Please check your network.',
      );
    case 'weak-password':
      return const InvalidCredentialsFailure(
        'Password is too weak. Try using a stronger one.',
      );
    case 'email-already-in-use':
      return const InvalidCredentialsFailure(
        'This email is already in use. Please log in instead.',
      );
    default:
      return ServerFailure('Something went wrong: Please try again.');
  }
}
