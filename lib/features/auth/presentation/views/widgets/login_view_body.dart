import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/helper/asset_helper.dart';
import 'package:i_smile_kids_app/core/helper/auth_validator.dart';
import 'package:i_smile_kids_app/core/helper/navigator_helper.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_snack_bar.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_cubit.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_state.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/complete_auth_view.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/create_account_view.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/custom_redirect_naviagor_message.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/custom_textform_field.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/social_auth_button.dart';
import 'package:i_smile_kids_app/features/home/presentation/views/home_view.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
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
                  children: [AssetHelper.imageAsset(name: 'logo')],
                ),
                BlocConsumer<AuthCubit, AuthCubitState>(
                  listener: (context, state) {
                    if (state is AuthCubitLoginSuccess) {
                      CustomSnackBar.successSnackBar(
                        state.succMessage,
                        context,
                      );
                      NavigatorHelper.pushReplaceMent(
                        context,
                        screen: HomeView(),
                      );
                    } else if (state is AuthCubitGoogleSigninSuccess) {
                      // show toast then check profile completeness and navigate accordingly
                      CustomSnackBar.successSnackBar(
                        state.succMessage,
                        context,
                      );

                      // run async check without making listener async
                      () async {
                        final bool isComplete = await cubit.isProfileComplete();
                        if (isComplete) {
                          NavigatorHelper.pushReplaceMent(
                            context,
                            screen: HomeView(),
                          );
                        } else {
                          NavigatorHelper.pushReplaceMent(
                            context,
                            screen: CompleteAuthView(cubit: cubit),
                          );
                        }
                      }();
                    } else if (state is AuthCubitGoogleSigninFailure) {
                      CustomSnackBar.errorSnackBar(state.errMessage, context);
                    } else if (state is AuthCubitLoginFailure) {
                      CustomSnackBar.errorSnackBar(state.errMessage, context);
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: cubit.loginGlobalKey,
                      child: Column(
                        spacing: 15.h,
                        children: [
                          CustomTextFormField(
                            title: 'Email',
                            controller: cubit.loginEmailController,
                            validator: (value) => checkEmailValidator(value),
                            prefixIcon: Icons.email_outlined,
                          ),
                          CustomTextFormField(
                            title: 'Password',
                            controller: cubit.loginPasswordController,
                            validator: (value) => checkPasswordValidator(value),
                            prefixIcon: Icons.lock,
                            obscureText: true,
                          ),
                          ForgetPassword(cubit: cubit),
                          Gap(30.h),
                          CustomEleveatedButton(
                            onPress: () {
                              cubit.login();

                              if (cubit.loginGlobalKey.currentState!
                                      .validate() &&
                                  state is AuthCubitLoginSuccess) {
                                NavigatorHelper.push(
                                  context,
                                  screen: CreateAccountView(),
                                );
                              }
                            },
                            // child: state is AuthCubiLoading
                            //     ? Center(
                            //         child: CircularProgressIndicator(
                            //           color: Colors.white,
                            //         ),
                            //       )
                            // :
                            child: Text(
                              'Login',
                              style: FontManger.whiteBoldFont18,
                            ),
                          ),
                          SocialAuthButton(
                            title: 'Login with Google',
                            logo: 'google',
                            onPress: () {
                              cubit.signinWithGoogle();
                            },
                          ),
                          SocialAuthButton(
                            textColor: ColorManager.textDark,
                            bgColor: Colors.white,
                            title: 'Login with Apple',
                            logo: 'apple',
                            onPress: () {},
                          ),
                          Gap(20.h),
                          CustomAuthRedirectText(
                            isLogin: true,
                            onTap: () => NavigatorHelper.pushReplaceMent(
                              context,
                              screen: CreateAccountView(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
