import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class CustomDoctorProfileAchivementsContainer extends StatelessWidget {
  const CustomDoctorProfileAchivementsContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.primaryColor,
    required this.subTitle,
  });
  final String title;
  final String subTitle;
  final IconData icon;
  final Color primaryColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 130,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        shadows: const [
          BoxShadow(
            color: Color(0x0C6A769A),
            blurRadius: 25,
            offset: Offset(0, 10),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        spacing: 10,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.r),
                bottomRight: Radius.circular(15.r),
              ),
            ),

            child: Icon(icon, color: primaryColor),
          ),
          Text(
            title,
            style: FontManger.blackBoldFont18.copyWith(fontSize: 15.sp),
          ),
          Text(
            subTitle,
            style: FontManger.subTitleTextBold14.copyWith(fontSize: 10.sp),
          ),
        ],
      ),
    );
  }
}
