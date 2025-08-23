import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/navigator_helper.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_logo_container.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/auth_view.dart';
import 'package:i_smile_kids_app/features/main/presentation/views/main_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) {
      if (context.mounted) {}
      if (FirebaseAuth.instance.currentUser == null) {
        if (mounted) {
          NavigatorHelper.pushReplaceMent(context, screen: AuthView());
        }
      } else {
        if (mounted) {
          NavigatorHelper.pushReplaceMent(context, screen: MainView());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLogoContainer(),
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
