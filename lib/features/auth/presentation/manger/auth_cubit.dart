import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/auth/data/repo/auht_repo_impl.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final AuthRepositoryImpl authRepo;
  AuthCubit(this.authRepo) : super(AuthCubitInitial());
  final TextEditingController loginEmailController = TextEditingController();
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
      password: loginEmailController.text,
    );
    result.fold(
      (left) => emit(AuthCubitLoginFailure(errMessage: left.toString())),
      (right) => emit(AuthCubitLoginSuccess(succMessage: 'Welcome Back')),
    );
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
