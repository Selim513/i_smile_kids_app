import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';

abstract class FontManger {
  static TextStyle primaryFontColorRoboto25 = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: 25.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.primary,
  );
  static TextStyle blackBoldFont18 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.textDark,
  );
  static TextStyle blackBoldFont20 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.textDark,
  );
  static TextStyle whiteBoldFont20 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.textLight,
  );
  static TextStyle textFomrHintFont14 = TextStyle(
    fontSize: 14.sp,
    color: Colors.grey,
  );
  static TextStyle regularFontBlack12 = TextStyle(
    fontSize: 12.sp,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );
  static TextStyle meduimFontBlack14 = TextStyle(
    fontSize: 14.sp,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );
  static TextStyle boldSecondaryColor12 = TextStyle(
    fontSize: 12.sp,
    color: ColorManager.secondary,
    fontWeight: FontWeight.bold,
  );
  static TextStyle subTitleTextBold14 = TextStyle(
    fontSize: 14.sp,
    color: const Color(0xff6B779A),
    fontWeight: FontWeight.bold,
  );
  static TextStyle balsamiqSansFontBold20 = TextStyle(
    fontSize: 20.sp,
    fontFamily: GoogleFonts.balsamiqSans().fontFamily,
    color: const Color(0xff6B779A),
    fontWeight: FontWeight.bold,
  );
}
