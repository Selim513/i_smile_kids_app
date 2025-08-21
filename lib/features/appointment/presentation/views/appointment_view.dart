import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/appointment_available_time_section.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/appointment_header_picked_date.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/patient_details_section.dart';

class BookAppointmentView extends StatefulWidget {
  const BookAppointmentView({super.key});

  @override
  State<BookAppointmentView> createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPrimaryAppbar(title: 'Appointment'),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 10.h, horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20.h,
            children: [
              AppointmentHeaderDatePicked(),
              AvailableTimeSection(),
              PatientDetails(),
              CustomEleveatedButton(
                onPress: () {},
                child: Text(
                  'Book Appointment now',
                  style: FontManger.whiteBoldFont18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
