// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
// import 'package:i_smile_kids_app/features/appointment_test/presentation/manger/book_appointment_cubit.dart';
// import 'package:i_smile_kids_app/features/appointment_test/presentation/manger/book_appointment_state.dart';
// import 'package:i_smile_kids_app/features/appointment_test/presentation/views/appointment_selector_test.dart';

// class AvailableTimeSectionTest extends StatelessWidget {
//   const AvailableTimeSectionTest({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       spacing: 10.h,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Available Time', style: FontManger.blackBoldFont18),
//         BlocBuilder<AppointmentCubit, AppointmentState>(
//           builder: (context, state) {
//             if (state is LoadingTimeSlots) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is TimeSlotsLoaded) {
//               if (state.timeSlots.isEmpty) {
//                 return Center(
//                   child: Text(
//                     'No available time slots for this date',
//                     style: FontManger.subTitleTextBold14,
//                   ),
//                 );
//               }
//               return AppointmentTimeSelectorTest(timeSlots: state.timeSlots);
//             } else if (state is AppointmentError) {
//               print(state.message);
//               return Center(
//                 child: Text(state.message, style: TextStyle(color: Colors.red)),
//               );
//             }
//             return SizedBox.shrink();
//           },
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/manger/book_appointment_cubit.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/manger/book_appointment_state.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/appointment_selector.dart';

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
              return AppointmentTimeSelectorTest(timeSlots: state.timeSlots);
            }
            // عرض المواعيد عند اختيار توقيت (للحفاظ على العرض)
            else if (state is TimeSlotSelected) {
              return AppointmentTimeSelectorTest(
                timeSlots: state.availableTimeSlots,
              );
            }
            // عرض المواعيد الحالية من الـ cubit
            else {
              final cubit = context.read<AppointmentCubit>();
              if (cubit.availableTimeSlots.isNotEmpty) {
                return AppointmentTimeSelectorTest(
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
