import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/asset_helper.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    required this.title,
    required this.onPress,
    required this.logo,
    this.bgColor,
    this.textColor,
  });
  final String title;
  final String logo;
  final Color? bgColor;
  final Color? textColor;
  final void Function() onPress;
  @override
  Widget build(BuildContext context) {
    return CustomEleveatedButton(
      bgColor: bgColor ?? ColorManager.secondary,
      onPress: onPress,
      child: Row(
        spacing: 10.w,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30.h,
            width: 30.w,
            child: AssetHelper.svgAssets(name: logo),
          ),
          Text(
            title,
            style: FontManger.whiteBoldFont20.copyWith(
              fontSize: 18.sp,
              color: textColor ?? ColorManager.background,
            ),
          ),
        ],
      ),
    );
  }
}
