import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:i_smile_kids_app/features/appointment/data/data_source/appointment_data_source.dart';
import 'package:i_smile_kids_app/features/appointment/data/repo/appointment_repo_impl.dart';
import 'package:i_smile_kids_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:i_smile_kids_app/features/auth/data/repo/auht_repo_impl.dart';
import 'package:i_smile_kids_app/features/profile/data/data_source/profile_data_remote_data_source.dart';
import 'package:i_smile_kids_app/features/profile/data/repo/profile_repo_impl.dart';

final GetIt getIt = GetIt.instance;
void serviceLocatorSetup() {
  //-instance from firebaseAuth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<User>(() => FirebaseAuth.instance.currentUser!);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  //-current user
  //-
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  //-
  getIt.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(getIt.get<AuthRemoteDataSource>()),
  );
  //-----Fetch user data

  getIt.registerLazySingleton<FetchProfileDataRemoteDataSourceImpl>(
    () => FetchProfileDataRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ProfileRepoImpl>(
    () => ProfileRepoImpl(getIt.get<FetchProfileDataRemoteDataSourceImpl>()),
  );
  //-Appointment
  getIt.registerLazySingleton<AppointmentRemoteDataSource>(
    () => AppointmentRemoteDataSource(),
  );
  getIt.registerLazySingleton<AppointmentRepositoryImpl>(
    () => AppointmentRepositoryImpl(getIt.get<AppointmentRemoteDataSource>()),
  );
}
