import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:i_smile_kids_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:i_smile_kids_app/features/auth/data/repo/auht_repo_impl.dart';

final GetIt getIt = GetIt.instance;
void serviceLocatorSetup() {
  //-instance from firebaseAuth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  //-
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  //-
  getIt.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(getIt.get<AuthRemoteDataSource>()),
  );
}
