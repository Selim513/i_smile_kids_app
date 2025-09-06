import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Text('Home', style: FontManger.blackBoldFont18),
        const Spacer(),
        Row(
          spacing: 5.w,
          children: [
            GestureDetector(
              onTap: () {
                // final dataSource = AppointmentRemoteDataSource();
                // await dataSource.initializeDoctorTimeSlots('doctor_1');
              },
              child: const Icon(
                FontAwesomeIcons.bell,
                color: ColorManager.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
