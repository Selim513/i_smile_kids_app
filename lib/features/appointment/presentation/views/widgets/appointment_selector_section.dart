import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentTimeSelector extends StatefulWidget {
  const AppointmentTimeSelector({super.key});

  @override
  State<AppointmentTimeSelector> createState() =>
      _AppointmentTimeSelectorState();
}

class _AppointmentTimeSelectorState extends State<AppointmentTimeSelector> {
  // قائمة بالأوقات
  final List<String> times = [
    "9:00 AM",
    "9:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: List.generate(times.length, (index) {
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green : Colors.white,
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  times[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
