import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/helper/auth_validator.dart';
import 'package:i_smile_kids_app/core/helper/navigator_helper.dart';
import 'package:i_smile_kids_app/core/services/service_locator.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_drop_down_field.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_snack_bar.dart';
import 'package:i_smile_kids_app/features/auth/data/repo/auht_repo_impl.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_cubit.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_state.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/complete_auth_view.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/create_account_view.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/login_view.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/custom_redirect_naviagor_message.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/custom_textform_field.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/social_auth_button.dart';
import 'package:i_smile_kids_app/features/main/presentation/views/main_view.dart';

class CreateAccountFormFieldSection extends StatelessWidget {
  const CreateAccountFormFieldSection({super.key, required this.cubit});

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(bottom: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BlocConsumer<AuthCubit, AuthCubitState>(
            listener: (context, state) {
              if (state is AuthCubitCreateAccountFailure) {
                CustomSnackBar.errorSnackBar(state.errMessage, context);
              } else if (state is AuthCubitCreateAccountSuccess) {
                CustomSnackBar.successSnackBar(state.succMessage, context);
                NavigatorHelper.pushReplaceMent(
                  context,
                  screen: const LoginView(),
                );
              } else if (state is AuthCubitGoogleSigninSuccess) {
                // when Google sign-in success -> check profile completeness then navigate
                () async {
                  CustomSnackBar.confrimEmailSnackBar(
                    state.succMessage,
                    context,
                  );

                  final cubit = context.read<AuthCubit>();
                  final isComplete = await cubit.isProfileComplete();

                  if (isComplete) {
                    // user already completed profile -> go to Home
                    if (context.mounted) {
                      NavigatorHelper.pushReplaceMent(
                        context,
                        screen: const MainView(),
                      );
                    }
                  } else {
                    // new user or incomplete -> go to complete profile page
                    if (context.mounted) {
                      NavigatorHelper.pushReplaceMent(
                        context,
                        screen: BlocProvider(
                          create: (context) =>
                              AuthCubit(getIt.get<AuthRepositoryImpl>()),
                          child: const CompleteAuthView(),
                        ),
                      );
                    }
                  }
                }();
              } else if (state is AuthCubitGoogleSigninFailure) {
                CustomSnackBar.errorSnackBar(state.errMessage, context);
              }
            },
            builder: (context, state) {
              return Form(
                key: cubit.createAccountGlobalKey,
                child: Column(
                  spacing: 15.h,
                  children: [
                    CustomTextFormField(
                      title: 'Name',
                      controller: cubit.nameController,
                      validator: (value) => checkNameValidator(value),

                      prefixIcon: Icons.person,
                    ),
                    ChildAgeDropDownFormField(controller: cubit.agrController),
                    CustomNationalityTextFormField(
                      controller: cubit.nationalityController,
                    ),
                    CustomEmirateOfResidencyDropDownTextFormField(
                      controller: cubit.emirateOfResidencyController,
                    ),
                    CustomTextFormField(
                      title: 'Email Address',
                      controller: cubit.createAccountEmailController,
                      validator: (value) => checkEmailValidator(value),
                      prefixIcon: Icons.email_outlined,
                    ),
                    CustomTextFormField(
                      title: 'Password',
                      controller: cubit.createAccountPasswordController,
                      validator: (value) => checkPasswordValidator(value),
                      prefixIcon: Icons.lock,
                      obscureText: true,
                    ),
                    CustomTextFormField(
                      title: 'Confirm password',
                      controller: cubit.createAccountConfirmPasswordController,
                      validator: (value) => checkConfirmPasswordValidator(
                        value: value,
                        password:
                            cubit.createAccountConfirmPasswordController.text,
                      ),
                      prefixIcon: Icons.lock,
                      obscureText: true,
                    ),

                    Gap(20.h),
                    CustomEleveatedButton(
                      onPress: () {
                        cubit.createAccount();
                        if (cubit.createAccountGlobalKey.currentState!
                                .validate() &&
                            state is AuthCubitCreateAccountSuccess) {
                          NavigatorHelper.push(
                            context,
                            screen: const CreateAccountView(),
                          );
                        }
                      },
                      child: state is AuthCubitCreateAccountLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: ColorManager.textLight,
                              ),
                            )
                          : Text(
                              'Create Account',
                              style: FontManger.whiteBoldFont20,
                            ),
                    ),
                    state is AuthCubitGoogleSigninLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.textLight,
                            ),
                          )
                        : SocialAuthButton(
                            title: 'Continue with Google',
                            logo: 'google',
                            onPress: () {
                              cubit.signinWithGoogle();
                            },
                          ),
                    SocialAuthButton(
                      textColor: ColorManager.textDark,
                      bgColor: Colors.white,
                      title: 'Continue with Apple',
                      logo: 'apple',
                      onPress: () {},
                    ),

                    CustomAuthRedirectText(
                      isLogin: false,
                      onTap: () => NavigatorHelper.pushReplaceMent(
                        context,
                        screen: const LoginView(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
