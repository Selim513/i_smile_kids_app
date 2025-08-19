import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/navigator_helper.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/create_account_view.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/login_view.dart';

class AuthButtonsWidget extends StatelessWidget {
  const AuthButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      children: [
        CustomEleveatedButton(
          onPress: () {
            NavigatorHelper.pushReplaceMent(context, screen: LoginView());
          },
          child: Text('Login', style: FontManger.whiteBoldFont18),
        ),
        CustomEleveatedButton(
          borderColor: Colors.grey,
          bgColor: Colors.white,

          onPress: () {
            NavigatorHelper.pushReplaceMent(
              context,
              screen: CreateAccountView(),
            );
          },
          child: Text('Create account', style: FontManger.blackBoldFont18),
        ),
      ],
    );
  }
}
