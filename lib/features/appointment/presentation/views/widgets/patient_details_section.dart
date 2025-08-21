
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/custom_textform_field.dart';

class PatientDetails extends StatelessWidget {
  const PatientDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Patient Details', style: FontManger.blackBoldFont18),
        CustomTextFormField(prefixIcon: Icons.person, title: 'Full name'),
        CustomTextFormField(prefixIcon: Icons.cake_rounded, title: 'Age'),
        CustomTextFormField(maxLines: 5, title: 'Write your problem'),
      ],
    );
  }
}
