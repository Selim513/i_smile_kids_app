
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class CustomFilterLoyaltyRewardButton extends StatelessWidget {
  const CustomFilterLoyaltyRewardButton({
    super.key,
    required this.title,
    this.onPressed,
  });
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.secondary,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: FontManger.whiteBoldFont20.copyWith(
            color: ColorManager.textLight,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }
}
