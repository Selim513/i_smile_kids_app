import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_cubit.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_state.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/fetch_profile_data_cubit/fetch_profile_data_cubit.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/fetch_profile_data_cubit/fetch_profile_data_state.dart';
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
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(15.w),
      child: SingleChildScrollView(
        child: BlocBuilder<FetchProfileDataCubit, FetchProfileDataCubitState>(
          builder: (context, state) {
            if (state is FetchProfileDataFailure) {
              return Center(
                child: CustomPrimaryContainer(
                  widgets: Text(
                    'Check your internet and try again later !',
                    style: FontManger.blackBoldFont18
                      ..copyWith(color: ColorManager.error),
                  ),
                ),
              );
            } else if (state is FetchProfileDataSuccess) {
              final userData = state.userData;

              return Column(
                spacing: 20.h,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ... Profile Image section ...
                  ProfileHeaderSection(
                    imareUrl: userData.photoURL,
                    name: userData.name,
                    email: userData.email,
                  ),
                  //...Personal Profile Details
                  const ProfileUserPersonalDetailsSection(),

                  BlocListener<AuthCubit, AuthCubitState>(
                    listener: (context, state) {
                      if (state is AuthCubitLogoutSuccess ||
                          state is AuthCubitInitial) {
                        // Navigate and clear all routes

                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const SplashView(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      } else if (state is AuthCubitLogoutFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.errMessage),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: CustomEleveatedButton(
                      bgColor: ColorManager.error,
                      onPress: () async {
                        // Show confirmation dialog
                        final shouldLogout =
                            await _showLogoutConfirmationDialog(context);
                        if (shouldLogout && context.mounted) {
                          await context.read<AuthCubit>().logout();
                        }
                      },
                      child: Text(
                        'Logout',
                        style: FontManger.whiteBoldFont20.copyWith(
                          color: ColorManager.textLight,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

Future<bool> _showLogoutConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: ColorManager.background,
          title: Text('Logout', style: FontManger.blackBoldFont18),
          content: Text(
            'Are you sure you want to logout ?',
            style: FontManger.blackBoldFont18.copyWith(
              color: ColorManager.error,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                'Cancle',
                style: FontManger.blackBoldFont18.copyWith(fontSize: 14.sp),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'Logout',
                style: FontManger.whiteBoldFont20.copyWith(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ) ??
      false;
}
