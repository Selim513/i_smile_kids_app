import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/appointment_test/data/data_source/appointment_data_source.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Text('Home', style: FontManger.blackBoldFont18),
        Spacer(),
        Row(
          spacing: 5.w,
          children: [
            GestureDetector(
              onTap: () async {
                final dataSource = AppointmentRemoteDataSource();
                await dataSource.initializeDoctorTimeSlots('doctor_1');
                print('Doneeeeeeeee');
              },
              child: Icon(FontAwesomeIcons.bell, color: ColorManager.primary),
            ),
            // CircleAvatar(
            //   radius: 20.r,
            //   backgroundImage: AssetHelper.assetImage(name: 'logo'),
            // ),
          ],
        ),
      ],
    );
  }
}
