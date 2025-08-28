import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_cubit.dart';

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
                  ? 'Dont have an account? '
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

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key, required this.cubit});
  final AuthCubit cubit;

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
            const TextSpan(text: 'Forget your password? '),
            TextSpan(
              text: 'Reset password',
              style: FontManger.blackBoldFont18.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: Colors.black,
                decorationThickness: 1.5,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
              // NavigatorHelper.push(context, screen: ResetPasswordView(cubit: cubit,)),
            ),
          ],
        ),
      ),
    );
  }
}
