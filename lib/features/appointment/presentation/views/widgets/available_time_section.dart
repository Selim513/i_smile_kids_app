
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/manger/book_appointment_cubit.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/manger/book_appointment_state.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/appointment_selector.dart';

class AvailableTimeSection extends StatelessWidget {
  const AvailableTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Time', style: FontManger.blackBoldFont18),
        BlocBuilder<AppointmentCubit, AppointmentState>(
          builder: (context, state) {
            // عرض loading أثناء تحميل المواعيد
            if (state is LoadingTimeSlots) {
              return const Center(child: CircularProgressIndicator());
            }
            // عرض المواعيد المتاحة
            else if (state is TimeSlotsLoaded) {
              if (state.timeSlots.isEmpty) {
                return Center(
                  child: Text(
                    'No available time slots for this date',
                    style: FontManger.subTitleTextBold14,
                  ),
                );
              }
              return AppointmentTimeSelector(timeSlots: state.timeSlots);
            }
            // عرض المواعيد عند اختيار توقيت (للحفاظ على العرض)
            else if (state is TimeSlotSelected) {
              return AppointmentTimeSelector(
                timeSlots: state.availableTimeSlots,
              );
            }
            // عرض المواعيد الحالية من الـ cubit
            else {
              final cubit = context.read<AppointmentCubit>();
              if (cubit.availableTimeSlots.isNotEmpty) {
                return AppointmentTimeSelector(
                  timeSlots: cubit.availableTimeSlots,
                );
              }
            }

            // في حالة عدم وجود بيانات
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
