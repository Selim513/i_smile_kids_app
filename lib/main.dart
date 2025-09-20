import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_smile_kids_app/core/observer/cubit_observer.dart';
import 'package:i_smile_kids_app/core/services/service_locator.dart';
import 'package:i_smile_kids_app/features/auth/data/repo/auht_repo_impl.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_cubit.dart';
import 'package:i_smile_kids_app/features/dashboard/data/repo/dashboard_repo.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/manger/appointment_cubit.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/manger/dashboard_cubit.dart';
import 'package:i_smile_kids_app/features/profile/data/repo/profile_repo_impl.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/fetch_profile_data_cubit/fetch_profile_data_cubit.dart';
import 'package:i_smile_kids_app/features/splash/presentation/splash_view.dart';
import 'package:i_smile_kids_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  serviceLocatorSetup();

  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const IsmileKids());
    // runApp(MyApp());
  });
}

class IsmileKids extends StatelessWidget {
  const IsmileKids({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              FetchProfileDataCubit(getIt.get<ProfileRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => AuthCubit(getIt.get<AuthRepositoryImpl>()),
        ),
        BlocProvider(
          create: (context) => DashboardCubit(DashboardRepository()),
        ),
        BlocProvider(
          create: (context) => AppointmentsListCubit(DashboardRepository()),
        ),
      ],

      child: ScreenUtilInit(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: GoogleFonts.inter().fontFamily,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: SplashView(),
        ),
      ),
    );
  }
}
