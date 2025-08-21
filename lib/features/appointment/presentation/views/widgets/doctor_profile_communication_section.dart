
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/custom_doctor_profile_comunication_widges.dart';

class DoctorProfileCommunicationSection extends StatelessWidget {
  const DoctorProfileCommunicationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Communication', style: FontManger.blackBoldFont18),
        Column(
          spacing: 10.h,
          children: [
            CustomDoctorComunicatonWidgets(
              icon: FontAwesomeIcons.envelope,
              subTitle: 'drahmedzayed@gmail.com',
              title: 'Email',
            ),
            CustomDoctorComunicatonWidgets(
              icon: FontAwesomeIcons.phone,
              subTitle: '012345678910',
              title: 'Phone Number',
            ),
          ],
        ),
      ],
    );
  }
}
