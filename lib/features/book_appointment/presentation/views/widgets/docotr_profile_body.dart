import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/models/doctors_model.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/views/patient_appointment_view.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/views/widgets/doctor_profile_about_doctor_section.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/views/widgets/doctor_profile_communication_section.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class DoctorProfileBody extends StatelessWidget {
  const DoctorProfileBody({super.key, required this.docData});
  final DoctorsModel docData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w, vertical: 10),
      child: Container(
        color: Colors.white,

        child: Column(
          spacing: 20.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DoctorProfileAboutDoctorSection(aboutDoctor: docData.aboutDoctor),
            // DoctorProfileWorkingTimeSection(),
            DoctorProfileCommunicationSection(),
            Gap(10.h),
            CustomEleveatedButton(
              onPress: () => PersistentNavBarNavigator.pushNewScreen(
                context,
                withNavBar: false,
                screen: PatientAppointmentView(docData: docData),
              ),
              child: Text(
                'Book Appointment',
                style: FontManger.whiteBoldFont20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
