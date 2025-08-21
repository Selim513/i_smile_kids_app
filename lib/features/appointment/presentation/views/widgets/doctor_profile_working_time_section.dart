
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class DoctorProfileWorkingTimeSection extends StatelessWidget {
  const DoctorProfileWorkingTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        Text('Working Time', style: FontManger.blackBoldFont18),
        Text(
          'Mon - Sat (08:30 AM - 09:00 PM)',
          style: FontManger.subTitleTextBold14,
        ),
      ],
    );
  }
}
