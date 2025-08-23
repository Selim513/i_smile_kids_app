import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:intl/intl.dart';

class AppointmentHeaderDatePicked extends StatefulWidget {
  const AppointmentHeaderDatePicked({super.key});

  @override
  State<AppointmentHeaderDatePicked> createState() =>
      _AppointmentHeaderDatePickedState();
}

class _AppointmentHeaderDatePickedState
    extends State<AppointmentHeaderDatePicked> {
  var selectedValue = DateFormat.yMMMd().format(DateTime.now()).toString();
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
          //  New date selected
          setState(() {
            selectedValue = date.toString();
            // print(_selectedValue);
          });
        },
      ),
    );
  }
}
