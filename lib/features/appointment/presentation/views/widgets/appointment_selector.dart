
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/appointment/data/models/time_slot_model.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/manger/book_appointment_cubit.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/manger/book_appointment_state.dart';

class AppointmentTimeSelector extends StatefulWidget {
  final List<TimeSlotModel> timeSlots;

  const AppointmentTimeSelector({super.key, required this.timeSlots});

  @override
  State<AppointmentTimeSelector> createState() =>
      _AppointmentTimeSelectorState();
}

class _AppointmentTimeSelectorState extends State<AppointmentTimeSelector> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        final cubit = context.read<AppointmentCubit>();
        final selectedTimeSlot = cubit.selectedTimeSlot;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.5,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
          ),
          itemCount: widget.timeSlots.length,
          itemBuilder: (context, index) {
            final timeSlot = widget.timeSlots[index];
            final isSelected = selectedTimeSlot == timeSlot.time;

            return GestureDetector(
              onTap: () {
                cubit.selectTimeSlot(timeSlot.time);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? ColorManager.primary : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? ColorManager.primary
                        : ColorManager.border,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    timeSlot.displayTime,
                    style: isSelected
                        ? FontManger.subTitleTextBold14.copyWith(
                            color: Colors.white,
                          )
                        : FontManger.meduimFontBlack14,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
