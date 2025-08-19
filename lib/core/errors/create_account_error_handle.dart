// Create Account Request Validation
import 'package:i_smile_kids_app/core/errors/auth_failure.dart';
import 'package:i_smile_kids_app/core/helper/auth_validator.dart';
import 'package:i_smile_kids_app/features/auth/data/models/create_account_model.dart';

AuthFailure? validateCreateAccountRequest(CreateAccountModel request) {
  if (request.name.isEmpty) {
    return const InvalidCredentialsFailure('Name is required.');
  }

  if (request.name.length < 2) {
    return const InvalidCredentialsFailure(
      'Name must be at least 2 characters long.',
    );
  }

  if (request.email.isEmpty) {
    return const InvalidCredentialsFailure('Email is required.');
  }

  if (!Validate.emailValidate(request.email)) {
    return const InvalidCredentialsFailure(
      'Please enter a valid email address.',
    );
  }

  if (request.password.isEmpty) {
    return const InvalidCredentialsFailure('Password is required.');
  }

  if (request.password.length < 6) {
    return const InvalidCredentialsFailure(
      'Password must be at least 6 characters long.',
    );
  }

  if (request.confirmPassword.isEmpty) {
    return const InvalidCredentialsFailure('Confirm password is required.');
  }

  if (request.password != request.confirmPassword) {
    return const InvalidCredentialsFailure('Passwords do not match.');
  }

  if (request.nationality.isEmpty) {
    return const InvalidCredentialsFailure('Nationality is required.');
  }

  if (request.emirateOfResidency.isEmpty) {
    return const InvalidCredentialsFailure('Emirate of residency is required.');
  }
  // if (request.profileImage == null) {
  //   return const InvalidCredentialsFailure('Profile image is required.');
  // }

  return null;
}
