import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';

class CustomEleveatedButton extends StatelessWidget {
  const CustomEleveatedButton({
    super.key,
    this.title,
    required this.onPress,
    this.width,
    this.height,
    this.raduis,
    this.padding,
    this.fontsize,
    this.bgColor,
    required this.child,
    this.borderColor,
  });
  final String? title;
  final void Function() onPress;
  final double? width;
  final double? height;
  final double? raduis;
  final EdgeInsetsGeometry? padding;
  final double? fontsize;
  final Color? bgColor;
  final Color? borderColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45.h,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: bgColor ?? ColorManager.primary,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(raduis ?? 47.r),
          ),
        ),
        onPressed: onPress,
        child: child,
      ),
    );
  }
}
