
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/asset_helper.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class DashboardPatientAppointmentContainer extends StatelessWidget {
  const DashboardPatientAppointmentContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        CircleAvatar(
          radius: 25.r,
          backgroundImage: AssetHelper.assetImage(
            name: 'boy',
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ahmed Selim',
              style: FontManger.blackBoldFont18,
            ),
            Text(
              'Age: 15',
              style: FontManger.subTitleTextBold14,
            ),
          ],
        ),
      ],
    );
  }
}
