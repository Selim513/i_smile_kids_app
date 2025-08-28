import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      if (!mounted) return;

      final complete = await isProfileComplete();

      if (context.mounted) {}
      if (FirebaseAuth.instance.currentUser == null) {
        if (mounted) {
          NavigatorHelper.pushReplaceMent(context, screen: const AuthView());
        }
      } else if (!complete) {
        if (mounted) {
          NavigatorHelper.pushReplaceMent(context, screen: const AuthView());
        }
      } else {
        if (mounted) {
          NavigatorHelper.pushReplaceMent(context, screen: const MainView());
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
