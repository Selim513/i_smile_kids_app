
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/asset_helper.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class DoctorsGridViewContainer extends StatelessWidget {
  const DoctorsGridViewContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(10.r),
      child: Container(
        padding: EdgeInsetsGeometry.symmetric(vertical: 10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 60,
              offset: Offset(0, 10),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          spacing: 10.h,
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage: AssetHelper.assetImage(name: 'doctor'),
            ),
            Text(
              'Dr. Ahmed Zayed',
              style: FontManger.regularFontBlack12.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorManager.secondary,
              ),
            ),
            Text(
              'General Dentistry',
              style: FontManger.regularFontBlack12.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorManager.success,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
