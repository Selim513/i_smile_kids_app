import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class DoctorProfileAboutDoctorSection extends StatelessWidget {
  const DoctorProfileAboutDoctorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About Doctor', style: FontManger.blackBoldFont18),
        Text(
          'I’m Dr. Ahmed Zayed, General Dentist, with over 9 years of experience. I have extensive clinical experience across prestigious dental clinics and hospitals in Egypt, and UAE delivering comprehensive dental care to dental Patients',
          style: FontManger.subTitleTextBold14,
        ),
      ],
    );
  }
}
