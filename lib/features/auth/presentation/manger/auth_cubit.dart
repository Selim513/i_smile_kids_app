import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/auth/data/models/create_account_model.dart';
import 'package:i_smile_kids_app/features/auth/data/repo/auht_repo_impl.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_state.dart';
import 'package:image_picker/image_picker.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final AuthRepositoryImpl authRepo;
  AuthCubit(this.authRepo) : super(AuthCubitInitial());

  File? pickedImage; // هنا الصورة ال متخزنة
  final ImagePicker _picker = ImagePicker();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController agrController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController emirateOfResidencyController =
      TextEditingController();
  final TextEditingController createAccountEmailController =
      TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController createAccountPasswordController =
      TextEditingController();
  final TextEditingController createAccountConfirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> loginGlobalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> createAccountGlobalKey = GlobalKey<FormState>();
  //-Login method
  void login() async {
    emit(AuthCubiLoading());

    final result = await authRepo.login(
      email: loginEmailController.text,
      password: loginPasswordController.text,
    );
    result.fold(
      (left) => emit(AuthCubitLoginFailure(errMessage: left.toString())),
      (right) => emit(AuthCubitLoginSuccess(succMessage: 'Welcome Back')),
    );
  }

  void createAccount() async {
    emit(AuthCubiLoading());
    final result = await authRepo.createAccount(
      account: CreateAccountModel(
        profileImage: pickedImage,
        age: agrController.text,
        name: nameController.text,
        email: createAccountEmailController.text,
        password: createAccountPasswordController.text,
        confirmPassword: createAccountConfirmPasswordController.text,
        nationality: nationalityController.text,
        emirateOfResidency: emirateOfResidencyController.text,
      ),
    );
    result.fold(
      (failure) =>
          emit(AuthCubitCreateAccountFailure(errMessage: failure.message)),
      (success) => emit(
        AuthCubitCreateAccountSuccess(succMessage: 'Account has been create !'),
      ),
    );
  }

  void signinWithGoogle() async {
    emit(AuthCubiLoading());
    final result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) =>
          emit(AuthCubitGoogleSigninFailure(errMessage: failure.message)),
      (success) => emit(AuthCubitGoogleSigninSuccess(succMessage: 'Welcome')),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 75,
      );
      if (pickedFile != null) {
        pickedImage = File(pickedFile.path);
        emit(AuthCubitPickImageSuccess(pickedFile.path));
      } else {
        emit(AuthCubitPickImageFailure("No image selected"));
      }
    } catch (e) {
      emit(AuthCubitPickImageFailure(e.toString()));
    }
  }
}

// cubit/login_cubit.dart

// class LoginCubit extends Cubit<LoginState> {
//   final AuthRepository authRepository;

//   LoginCubit({required this.authRepository}) : super(LoginInitial());

//   Future<void> login({required String email, required String password}) async {
//     emit(LoginLoading());

//     final result = await authRepository.login(email: email, password: password);

//     result.fold(
//       (failure) => emit(LoginFailure(failure.message)),
//       (user) => emit(LoginSuccess(user)),
//     );
//   }

//   Future<void> logout() async {
//     emit(LoginLoading());

//     final result = await authRepository.logout();

//     result.fold(
//       (failure) => emit(LoginFailure(failure.message)),
//       (_) => emit(LoginInitial()),
//     );
//   }

//   void resetState() {
//     emit(LoginInitial());
//   }
// }
