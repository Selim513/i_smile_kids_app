import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/manger/book_appointment_cubit.dart';

class AppointmentHeaderDatePickedTest extends StatefulWidget {
  const AppointmentHeaderDatePickedTest({super.key});

  @override
  State<AppointmentHeaderDatePickedTest> createState() =>
      _AppointmentHeaderDatePickedTestState();
}

class _AppointmentHeaderDatePickedTestState
    extends State<AppointmentHeaderDatePickedTest> {
  @override
  void initState() {
    super.initState();
    // تحميل المواعيد المتاحة عند فتح الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppointmentCubit>().getAvailableTimeSlots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: ColorManager.border)),
      height: 70.h,
      child: DatePicker(
        DateTime.now(),
        daysCount: 30,
        initialSelectedDate: DateTime.now(),
        selectionColor: ColorManager.primary,
        selectedTextColor: Colors.white,
        dateTextStyle: FontManger.regularFontBlack12,
        monthTextStyle: FontManger.regularFontBlack12,
        dayTextStyle: FontManger.regularFontBlack12,
        onDateChange: (date) {
          context.read<AppointmentCubit>().selectDate(date);
        },
      ),
    );
  }
}