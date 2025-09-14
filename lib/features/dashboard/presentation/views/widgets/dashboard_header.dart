import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key, required this.appointmentCount});
  final int appointmentCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Expanded(
          child: CustomPrimaryContainer(
            padding: EdgeInsets.all(17.r),
            widgets: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                Icon(
                  FontAwesomeIcons.calendarCheck,
                  color: ColorManager.primary,
                ),
                Text(
                  'Today\'s Appointments',
                  style: FontManger.textFomrHintFont14,
                ),
                Text('$appointmentCount', style: FontManger.blackBoldFont18),
              ],
            ),
          ),
        ),
        Expanded(
          child: CustomPrimaryContainer(
            padding: EdgeInsets.all(17.r),
            widgets: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                Icon(Icons.person_2, color: ColorManager.primary),
                Text('Total Patient', style: FontManger.textFomrHintFont14),
                Gap(5.h),
                Text('8', style: FontManger.blackBoldFont18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
