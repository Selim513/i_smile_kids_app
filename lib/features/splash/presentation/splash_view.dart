import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/core/helper/navigator_helper.dart';
import 'package:i_smile_kids_app/core/services/firebase_point_manger.dart';
import 'package:i_smile_kids_app/core/services/service_locator.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_logo_container.dart';
import 'package:i_smile_kids_app/core/widgets/custom_snack_bar.dart';
import 'package:i_smile_kids_app/features/auth/data/repo/auht_repo_impl.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_cubit.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/auth_view.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/complete_auth_view.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:i_smile_kids_app/features/main/presentation/views/main_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {


  void _checkUserStatus() {
    // We wrap this in a BlocProvider to have access to the AuthCubit
    final authCubit = AuthCubit(getIt.get<AuthRepositoryImpl>());

    Future.delayed(const Duration(seconds: 2)).then((_) async {
      if (!mounted) return;

      final currentUser = FirebaseHelper.userAuth.currentUser;

      if (currentUser == null) {
        // No user logged in, go to Auth screen
        NavigatorHelper.pushReplaceMent(context, screen: const AuthView());
      } else {
        // User is logged in

        // <<< SOLUTION FOR PROBLEM 2 >>>
        // Check if the user is the Admin
        if (currentUser.uid == '2LDxPhHoEKQPUE4G2DxECQNw4sF3') {
          // Navigate to Dashboard
          // Note: Create a DashboardView() widget for this to work
          NavigatorHelper.pushReplaceMent(
            context,
            screen: const DashboardView(),
          );
          return; // Stop further execution
        }

        // <<< SOLUTION FOR PROBLEM 1 >>>
        // Check profile completeness using the CUBIT
        final isComplete = await authCubit.isProfileComplete();

        if (!mounted) return;

        if (isComplete) {
          // Profile is complete, go to MainView
          final reward = await giveDailyReward();
          if (mounted && reward) {
            CustomSnackBar.successSnackBar(
              'Thanks for logging in! You just received 5 points for your daily login.',
              context,
            );
          }
          NavigatorHelper.pushReplaceMent(context, screen: const MainView());
        } else {
          // Profile is not complete, go to CompleteAuthView
          NavigatorHelper.pushReplaceMent(
            context,
            screen: BlocProvider.value(
              value: authCubit, // Pass the existing cubit instance
              child: const CompleteAuthView(),
            ),
          );
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
    // Future.delayed(const Duration(seconds: 2)).then((value) async {
    //   if (!mounted) return;

    //   final complete = await isProfileComplete();

    //   if (context.mounted) {}
    //   if (FirebaseHelper.userAuth.currentUser == null) {

    //     if (mounted) {
    //       NavigatorHelper.pushReplaceMent(context, screen: const AuthView());
    //     }
    //   } else if (!complete) {
    //     if (mounted) {
    //       NavigatorHelper.pushReplaceMent(
    //         context,
    //         screen: BlocProvider(
    //           create: (context) => AuthCubit(getIt.get<AuthRepositoryImpl>()),
    //           child: const CompleteAuthView(),
    //         ),
    //       );
    //     }
    //   } else {
    //     if (mounted) {
    //       final reward = await giveDailyReward();

    //       if (reward) {
    //         CustomSnackBar.successSnackBar(
    //           'Thanks for logging in! You just received 5 points for your daily login.',
    //           context,
    //         );
    //       }
    //       NavigatorHelper.pushReplaceMent(context, screen: const MainView());
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomLogoContainer(),
            Text(
              'We care about your little smile 😀',
              style: FontManger.primaryFontColorRoboto25,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
