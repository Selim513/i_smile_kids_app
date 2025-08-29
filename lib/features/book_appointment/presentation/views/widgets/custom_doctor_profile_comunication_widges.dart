import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class CustomDoctorComunicatonWidgets extends StatelessWidget {
  const CustomDoctorComunicatonWidgets({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });
  final String title;
  final String subTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15.w,
      children: [
        Icon(icon),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5.h,
          children: [
            Text(
              title,
              style: FontManger.blackBoldFont18.copyWith(fontSize: 16),
            ),
            Text(subTitle, style: FontManger.subTitleTextBold14),
          ],
        ),
      ],
    );
  }
}
