import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_cubit.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/fetch_profile_data_cubit/fetch_profile_data_cubit.dart';
import 'package:i_smile_kids_app/features/profile/presentation/views/widgets/profile_header_section.dart';
import 'package:i_smile_kids_app/features/profile/presentation/views/widgets/profile_user_personal_details_section.dart';
import 'package:i_smile_kids_app/features/splash/presentation/splash_view.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<FetchProfileDataCubit>().fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseHelper.userAuth.currentUser;
    return Padding(
      padding: EdgeInsetsGeometry.all(15.w),
      child: SingleChildScrollView(
        child: Column(
          spacing: 20.h,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileHeaderSection(
              imareUrl: user?.photoURL,
              //  imareUrl
              name: user?.displayName,
              //  name
              email: user?.email,
              // email
            ),
            const ProfileUserPersonalDetailsSection(),
            CustomEleveatedButton(
              bgColor: ColorManager.error,
              onPress: () async {
                // <<< MODIFIED PART >>>
                // Call the cubit's logout method
                await context.read<AuthCubit>().logout();

                if (mounted) {
                  // This navigation is correct for resetting the app
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const SplashView()),
                    (Route<dynamic> route) => false,
                  );
                }
              },
              child: Text(
                'Logout',
                style: FontManger.whiteBoldFont20.copyWith(
                  color: ColorManager.textLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
