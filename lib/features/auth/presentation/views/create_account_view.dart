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
import 'package:i_smile_kids_app/features/auth/presentation/views/login_view.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/custom_textform_field.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/login_view_body.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      body: Padding(
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
                        'Create Account',
                        style: FontManger.blackBoldFont18.copyWith(
                          color: ColorManager.primary,
                          fontSize: 40.sp,
                        ),
                      ),
                    ],
                  ),
                  BlocConsumer<AuthCubit, AuthCubitState>(
                    listener: (context, state) {
                      if (state is AuthCubitCreateAccountFailure) {
                        CustomSnackBar.errorSnackBar(state.errMessage, context);
                      } else if (state is AuthCubitCreateAccountSuccess) {
                        CustomSnackBar.successSnackBar(
                          state.succMessage,
                          context,
                        );
                      }
                    },
                    builder: (context, state) {
                      return Form(
                        key: cubit.createAccountGlobalKey,
                        child: Column(
                          spacing: 15.h,
                          children: [
                            CustomTextFormField(
                              controller: cubit.createAccountEmailController,
                              validator: (value) => checkEmailValidator(value),
                              hintText: 'Email Address',
                              prefixIcon: Icons.email_outlined,
                            ),
                            CustomTextFormField(
                              controller: cubit.createAccountPasswordController,
                              validator: (value) =>
                                  checkPasswordValidator(value),
                              hintText: 'Password',
                              prefixIcon: Icons.lock,
                              obscureText: true,
                            ),
                            CustomTextFormField(
                              controller: cubit.createAccountPasswordController,
                              validator: (value) =>
                                  checkConfirmPasswordValidator(
                                    value: value,
                                    password: cubit
                                        .createAccountConfirmPasswordController
                                        .text,
                                  ),
                              hintText: 'Password',
                              prefixIcon: Icons.lock,
                              obscureText: true,
                            ),

                            Gap(30.h),
                            CustomEleveatedButton(
                              onPress: () {
                                if (cubit.createAccountGlobalKey.currentState!
                                    .validate()) {
                                  NavigatorHelper.push(
                                    context,
                                    screen: CreateAccountView(),
                                  );
                                }
                              },
                              child: Text(
                                'Login',
                                style: FontManger.whiteBoldFont18,
                              ),
                            ),
                            CustomAuthRedirectText(
                              isLogin: false,
                              onTap: () => NavigatorHelper.push(
                                context,
                                screen: LoginView(),
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
      ),
    );
  }
}
