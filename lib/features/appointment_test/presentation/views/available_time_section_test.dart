import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/appointment_test/presentation/manger/book_appointment_cubit.dart';
import 'package:i_smile_kids_app/features/appointment_test/presentation/manger/book_appointment_state.dart';
import 'package:i_smile_kids_app/features/appointment_test/presentation/views/appointment_selector_test.dart';

class AvailableTimeSectionTest extends StatelessWidget {
  const AvailableTimeSectionTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Time', style: FontManger.blackBoldFont18),
        BlocBuilder<AppointmentCubit, AppointmentState>(
          builder: (context, state) {
            if (state is LoadingTimeSlots) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TimeSlotsLoaded) {
              if (state.timeSlots.isEmpty) {
                return Center(
                  child: Text(
                    'No available time slots for this date',
                    style: FontManger.subTitleTextBold14,
                  ),
                );
              }
              return AppointmentTimeSelectorTest(timeSlots: state.timeSlots);
            } else if (state is AppointmentError) {
              print(state.message);
              return Center(
                child: Text(state.message, style: TextStyle(color: Colors.red)),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
