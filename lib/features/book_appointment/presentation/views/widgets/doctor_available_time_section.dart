import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/views/widgets/book_appointment_selector.dart';

class DoctorAvailableTimeSection extends StatelessWidget {
  const DoctorAvailableTimeSection({
    super.key,
    required this.slots,
    required this.selectedDate,
    this.selectedTime,
    required this.onTimeChanged,
  });

  final List<String> slots;
  final DateTime selectedDate;
  final String? selectedTime;
  final Function(String) onTimeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Time', style: FontManger.blackBoldFont18),
        SizedBox(height: 10.h),
        slots.isEmpty
            ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Text(
                    'No available times for this date',
                    style: FontManger.subTitleTextBold14,
                  ),
                ),
              )
            : BookAppointmentTimeSelector(
                slots: slots,
                selectedTime: selectedTime,
                onTimeChanged: onTimeChanged,
              ),
      ],
    );
  }
}
