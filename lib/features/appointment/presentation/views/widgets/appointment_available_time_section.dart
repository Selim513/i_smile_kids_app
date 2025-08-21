
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/appointment_selector_section.dart';

class AvailableTimeSection extends StatelessWidget {
  const AvailableTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Time', style: FontManger.blackBoldFont18),
        AppointmentTimeSelector(),
      ],
    );
  }
}
