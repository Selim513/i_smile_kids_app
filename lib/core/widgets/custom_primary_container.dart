import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';

class CustomPrimaryContainer extends StatelessWidget {
  const CustomPrimaryContainer({
    super.key,
    required this.widgets,
    this.bgColor,
    this.padding,
    this.width,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
  });
  final Widget widgets;
  final Color? bgColor;
  final double? width;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      padding:
          padding ?? EdgeInsets.symmetric(vertical: 20.h, horizontal: 22.w),

      decoration: BoxDecoration(
        boxShadow: boxShadow,
        color: bgColor ?? Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: borderColor ?? ColorManager.lightGreyColor,
          width: borderWidth ?? 1,
        ),
      ),
      child: widgets,
    );
  }
}
