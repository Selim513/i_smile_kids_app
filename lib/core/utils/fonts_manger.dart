import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';

abstract class FontManger {
  static TextStyle blackBoldFont18 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.textDark,
  );
  static TextStyle whiteBoldFont18 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.textLight,
  );
  static TextStyle textFomrHintFont14 = TextStyle(
    fontSize: 14.sp,
    color: Colors.grey,
  );
}
