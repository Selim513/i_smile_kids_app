import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/helper/asset_helper.dart';
import 'package:i_smile_kids_app/core/helper/auth_validator.dart';
import 'package:i_smile_kids_app/core/helper/navigator_helper.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/create_account_view.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/custom_textform_field.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  spacing: 30.h,
                  children: [
                    AssetHelper.imageAsset(name: 'logo'),
                    Text(
                      'Login',
                      style: FontManger.blackBoldFont18.copyWith(
                        color: ColorManager.primary,
                        fontSize: 40.sp,
                      ),
                    ),
                  ],
                ),
                Form(
                  child: Column(
                    spacing: 15.h,
                    children: [
                      CustomTextFormField(
                        controller: TextEditingController(),
                        validator: (value) => checkEmailValidator(value),
                        hintText: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                      ),
                      CustomTextFormField(
                        controller: TextEditingController(),
                        validator: (value) => checkPasswordValidator(value),
                        hintText: 'Password',
                        prefixIcon: Icons.lock,
                        obscureText: true,
                      ),

                      Gap(30.h),
                      CustomEleveatedButton(
                        onPress: () {
                          NavigatorHelper.push(
                            context,
                            screen: CreateAccountView(),
                          );
                        },
                        child: Text('Login', style: FontManger.whiteBoldFont18),
                      ),
                      Gap(20.h),
                      CustomAuthRedirectText(
                        isLogin: true,
                        onTap: () => NavigatorHelper.push(
                          context,
                          screen: CreateAccountView(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAuthRedirectText extends StatelessWidget {
  const CustomAuthRedirectText({super.key, this.onTap, required this.isLogin});
  final bool isLogin;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: FontManger.blackBoldFont18.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
          ),
          children: [
            TextSpan(
              text: isLogin
                  ? 'Dont have an account '
                  : 'Already Have an account? ',
            ),
            TextSpan(
              text: isLogin ? 'Join' : 'Login',
              style: FontManger.blackBoldFont18.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: Colors.black,
                decorationThickness: 1.5,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
