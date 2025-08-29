import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientAppointmentHeaderDatePicked extends StatefulWidget {
  final List<String> workingDays;
  final Function(DateTime) onDateChanged;

  const PatientAppointmentHeaderDatePicked({
    super.key,
    required this.workingDays,
    required this.onDateChanged,
  });

  @override
  State<PatientAppointmentHeaderDatePicked> createState() =>
      _PatientAppointmentHeaderDatePickedState();
}

class _PatientAppointmentHeaderDatePickedState
    extends State<PatientAppointmentHeaderDatePicked> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: DatePicker(
        DateTime.now(),
        daysCount: 30,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.green,
        deactivatedColor: Colors.grey,
        activeDates: _getActiveDates(),
        onDateChange: (date) {
          final dayName = DateFormat('EEEE').format(date);

          if (widget.workingDays.contains(dayName)) {
            setState(() {
              selectedDate = date;
            });
            widget.onDateChanged(date);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Doctor is not available today"),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
      ),
    );
  }

  /// Get active day (Working days)
  List<DateTime> _getActiveDates() {
    List<DateTime> activeDates = [];
    DateTime currentDate = DateTime.now();

    for (int i = 0; i < 30; i++) {
      DateTime date = currentDate.add(Duration(days: i));
      String dayName = DateFormat('EEEE').format(date);

      if (widget.workingDays.contains(dayName)) {
        activeDates.add(date);
      }
    }

    return activeDates;
  }
}
