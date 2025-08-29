import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class DoctorProfileAboutDoctorSection extends StatelessWidget {
  const DoctorProfileAboutDoctorSection({super.key, required this.aboutDoctor});
  final String aboutDoctor;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About Doctor', style: FontManger.blackBoldFont18),
        Text(
          "$aboutDoctor.",
          textAlign: TextAlign.center,
          style: FontManger.subTitleTextBold14,
        ),
      ],
    );
  }
}
