import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
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
  String? imareUrl;
  String? name;
  String? email;
  // late UserModel userData;
  @override
  void initState() {
    super.initState();
    context.read<FetchProfileDataCubit>().fetchProfileData();
    imareUrl = FirebaseHelper.user!.photoURL;
    name = FirebaseHelper.user!.displayName;
    email = FirebaseHelper.user!.email;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(15.w),
      child: Expanded(
        child: Column(
          spacing: 20.h,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileHeaderSection(imareUrl: imareUrl, name: name, email: email),
            ProfileUserPersonalDetailsSection(),
            CustomEleveatedButton(
              bgColor: ColorManager.error,
              onPress: () async {
                FirebaseHelper.userAuth.signOut().then((value) {
                  if (context.mounted) {
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const SplashView(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }
                });
              },
              child: Text(
                'Logout',
                style: FontManger.whiteBoldFont18.copyWith(
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


                      // CustomTextFormField(
                      //   controller: cubit.nameController,
                      //   // readOnly: true,
                      //   hintText: userData?.name,
                      // ),
                      // ChildAgeDropDownFormField(
                      //   labelText: userData?.age,
                      //   controller: cubit.ageController,
                      // ),
                      // CustomNationalityTextFormField(
                      //   hintText: userData?.nationality,
                      //   controller: cubit.nationalityController,
                      // ),
                      // CustomEmirateOfResidencyDropDownTextFormField(
                      //   hintText: userData?.emirateOfResidency,
                      //   controller: cubit.emirateController,
                      // ),
            // CustomEleveatedButton(
            //   onPress: () {
            //     cubit.updateProfileData();
            //   },
            //   child: Text('Save Changes', style: FontManger.whiteBoldFont18),
            // ),