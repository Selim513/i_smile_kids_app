import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:i_smile_kids_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:i_smile_kids_app/features/auth/data/repo/auht_repo_impl.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/data_source/doctors_data_source.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/repo/doctors_repo/docotrs_repo.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/repo/doctors_repo/doctors_repo_impl.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/data/data_source/dental_care_tips_remote_data_source.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/data/repo/dental_care_tips_repo_impl.dart';
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

  //-Fetch User data
  getIt.registerLazySingleton<DoctorsRemoteDataSource>(
    () => DoctorsRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<DocotrsDataRepo>(
    () => DoctorsDataRepoImpl(getIt.get<DoctorsRemoteDataSource>()),
  );
  //- Fetch Dental Care tips
  getIt.registerLazySingleton<DentalCareTipsRemoteDataSource>(
    () => DentalCareTipsRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<DentalCareTipsRepoImpl>(
    () => DentalCareTipsRepoImpl(getIt.get<DentalCareTipsRemoteDataSource>()),
  );
}
