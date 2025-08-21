import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_smile_kids_app/core/services/service_locator.dart';
import 'package:i_smile_kids_app/features/auth/data/repo/auht_repo_impl.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_cubit.dart';
import 'package:i_smile_kids_app/features/main/presentation/views/main_view.dart';
import 'package:i_smile_kids_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  serviceLocatorSetup();
  runApp(
    DevicePreview(
      builder: (context) => const IsmileKids(),
      isToolbarVisible: true,
    ),
  );
}

class IsmileKids extends StatelessWidget {
  const IsmileKids({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: BlocProvider(
        create: (context) => AuthCubit(getIt.get<AuthRepositoryImpl>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: GoogleFonts.inter().fontFamily,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: MainView(),
        ),
      ),
    );
  }
}
