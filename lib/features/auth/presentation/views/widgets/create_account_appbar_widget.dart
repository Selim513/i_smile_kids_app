import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class CreateAccountAppbarWidget extends StatelessWidget {
  const CreateAccountAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Create Account',
          style: FontManger.primaryFontColorRoboto25.copyWith(
            color: ColorManager.secondary,
          ),
        ),
      ],
    );
  }
}
