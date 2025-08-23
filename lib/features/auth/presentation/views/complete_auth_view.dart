import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/helper/navigator_helper.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_auth_appbar.dart';
import 'package:i_smile_kids_app/core/widgets/custom_drop_down_field.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_snack_bar.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_cubit.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_state.dart';
import 'package:i_smile_kids_app/features/main/presentation/views/main_view.dart';

class CompleteAuthView extends StatelessWidget {
  const CompleteAuthView({super.key, required this.cubit});
  final AuthCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAuthAppbar(title: 'Complete Profile'),
      body: Padding(
        padding: EdgeInsetsGeometry.all(15.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<AuthCubit, AuthCubitState>(
              listener: (context, state) {
                if (state is AuthCubitUpdateUserSuccess) {
                  CustomSnackBar.successSnackBar('Your all done !', context);
                  NavigatorHelper.pushReplaceMent(context, screen: MainView());
                } else if (state is AuthCubitUpdateUserFailure) {
                  print('-------${state.errMessage}');
                  CustomSnackBar.errorSnackBar(state.errMessage, context);
                }
              },
              builder: (context, state) {
                return Form(
                  key: cubit.completeAccountGlobalKey,
                  child: Column(
                    spacing: 15.h,
                    children: [
                      // CreateAccountPickProfileImage(),
                      Gap(30.h),
                      ChildAgeDropDownFormField(
                        controller: cubit.agrController,
                      ),
                      CustomNationalityTextFormField(
                        controller: cubit.nationalityController,
                      ),
                      CustomEmirateOfResidencyDropDownTextFormField(
                        controller: cubit.emirateOfResidencyController,
                      ),
                      Gap(10.h),
                      CustomEleveatedButton(
                        onPress: () {
                          if (cubit.completeAccountGlobalKey.currentState!
                              .validate()) {
                            cubit.updateUserData();
                          }
                        },
                        child: Text(
                          'Continue',
                          style: FontManger.whiteBoldFont18,
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
    );
  }
}
