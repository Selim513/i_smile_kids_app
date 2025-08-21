import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_auth_appbar.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_snack_bar.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_cubit.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_state.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/custom_textform_field.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.cubit});
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAuthAppbar(title: 'Reset password'),

      body: Padding(
        padding: EdgeInsetsGeometry.all(20.r),
        child: BlocConsumer<AuthCubit, AuthCubitState>(
          listener: (context, state) {
            if (state is AuthCubitPasswordResetSuccess) {
              CustomSnackBar.successSnackBar(state.message, context);
            } else if (state is AuthCubitPasswordResetFailure) {
              CustomSnackBar.successSnackBar(state.errMessage, context);
            }
          },
          builder: (context, state) => Form(
            key: cubit.resetPasswordGlobalKey,
            child: Column(
              spacing: 30.h,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  controller: cubit.resetPasswordEmailController,
                  prefixIcon: Icons.email,
                  title: 'Email address',
                ),
                CustomEleveatedButton(
                  onPress: () {
                    print('=====${cubit.resetPasswordEmailController.text}');
                    if (cubit.resetPasswordGlobalKey.currentState!.validate()) {
                      cubit.sendPasswordReset();
                    }
                  },
                  child: Text(
                    'Reset Password',
                    style: FontManger.whiteBoldFont18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
