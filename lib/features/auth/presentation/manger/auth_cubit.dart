import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/core/helper/auth_validator.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/features/auth/data/models/create_account_model.dart';
import 'package:i_smile_kids_app/features/auth/data/repo/auht_repo_impl.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final AuthRepositoryImpl authRepo;
  AuthCubit(this.authRepo) : super(AuthCubitInitial());

  // File? pickedImage; // هنا الصورة ال متخزنة
  // final ImagePicker _picker = ImagePicker();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController resetPasswordEmailController =
      TextEditingController();
  final TextEditingController agrController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  // final TextEditingController nationalityController = TextEditingController();
  // final TextEditingController emirateOfResidencyController =
  //     TextEditingController();
  final TextEditingController createAccountEmailController =
      TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController createAccountPasswordController =
      TextEditingController();
  final TextEditingController createAccountConfirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> loginGlobalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> completeAccountGlobalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> createAccountGlobalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPasswordGlobalKey = GlobalKey<FormState>();
  //-Login method
  void login() async {
    emit(AuthCubitLoginLoading());

    final result = await authRepo.login(
      email: loginEmailController.text,
      password: loginPasswordController.text,
    );
    result.fold(
      (left) => emit(AuthCubitLoginFailure(errMessage: left.toString())),
      (right) {
        final user = FirebaseHelper.user;

        if (user != null && user.uid == '2LDxPhHoEKQPUE4G2DxECQNw4sF3') {
          emit(AuthCubitAdminLoginSuccess(succMessage: 'Welcome Doctor Afaf'));
        } else {
          emit(AuthCubitLoginSuccess(succMessage: 'Welcome Back'));
        }
      },
    );
  }

  void createAccount() async {
    emit(AuthCubitCreateAccountLoading());
    final result = await authRepo.createAccount(
      account: CreateAccountModel(
        age: agrController.text,
        name: nameController.text,
        email: createAccountEmailController.text,
        password: createAccountPasswordController.text,
        confirmPassword: createAccountConfirmPasswordController.text,
        // nationality: nationalityController.text,
        // emirateOfResidency: emirateOfResidencyController.text,
      ),
    );
    result.fold(
      (failure) =>
          emit(AuthCubitCreateAccountFailure(errMessage: failure.message)),
      (success) => emit(
        AuthCubitCreateAccountSuccess(
          succMessage: 'Success! Your account has been created',
        ),
      ),
    );
  }

  void signinWithGoogle() async {
    emit(AuthCubitGoogleSigninLoading());
    final result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) =>
          emit(AuthCubitGoogleSigninFailure(errMessage: failure.message)),
      (success) =>
          emit(AuthCubitGoogleSigninSuccess(succMessage: 'Welcome Back')),
    );
  }

  Future<void> sendPasswordReset() async {
    // optional: basic local validation
    if (resetPasswordEmailController.text.trim().isEmpty) {
      emit(AuthCubitPasswordResetFailure('Email is required.'));
      return;
    }
    // if you have checkEmailValidator that returns message or null, use it:
    final emailError = checkEmailValidator(resetPasswordEmailController.text);
    if (emailError != null) {
      emit(AuthCubitPasswordResetFailure(emailError));
      return;
    }

    emit(AuthCubitResetPassowrdLoading());
    final result = await authRepo.sendPasswordResetEmail(
      email: resetPasswordEmailController.text,
    );
    result.fold(
      (failure) => emit(AuthCubitPasswordResetFailure(failure.message)),
      (_) => emit(
        AuthCubitPasswordResetSuccess(
          'Password reset email sent. Check your inbox.',
        ),
      ),
    );
  }

  Future<void> updateUserData() async {
    emit(AuthCubitUpdateUserDataLoading());
    try {
      await authRepo.updateUserData(
        uid: FirebaseAuth.instance.currentUser!.uid,
        name: nameController.text,
        age: agrController.text,
        // nationality: nationalityController.text,
        // emirateOfResidency: emirateOfResidencyController.text,
        // photoURL: pickedImage,
      );
      emit(
        AuthCubitUpdateUserSuccess(
          succMessage: "User data updated successfully",
        ),
      );
    } catch (e) {
      emit(AuthCubitUpdateUserFailure(errMessage: e.toString()));
    }
  }

  Future<bool> isProfileComplete() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (!doc.exists) return false;

      final data = doc.data() ?? {};

      // List the fields you require for a "complete" profile
      final required = ['age', 'nationality', 'emirateOfResidency'];

      for (final field in required) {
        final value = data[field];
        if (value == null) return false;
        if (value is String && value.trim().isEmpty) return false;
      }

      // optional: require photoURL too
      // if ((data['photoURL'] ?? '').toString().trim().isEmpty) return false;

      return true;
    } catch (e) {
      // on error assume not complete (or you can rethrow / handle)
      debugPrint('isProfileComplete error: $e');
      return false;
    }
  }
}
