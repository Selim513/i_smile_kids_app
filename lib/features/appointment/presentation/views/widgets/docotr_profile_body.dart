import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/helper/navigator_helper.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/doctor_profile_about_doctor_section.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/doctor_profile_communication_section.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/doctor_profile_working_time_section.dart';
import 'package:i_smile_kids_app/features/appointment/data/data_source/appointment_data_source.dart';
import 'package:i_smile_kids_app/features/appointment/data/repo/appointment_repo_impl.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/manger/book_appointment_cubit.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/book_appointment_view.dart';

class DoctorProfileBody extends StatelessWidget {
  const DoctorProfileBody({super.key});

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
            DoctorProfileAboutDoctorSection(),
            DoctorProfileWorkingTimeSection(),
            DoctorProfileCommunicationSection(),
            Gap(10.h),
            CustomEleveatedButton(
              onPress: () => NavigatorHelper.push(
                context,
                screen: BlocProvider(
                  create: (context) => AppointmentCubit(
                    AppointmentRepositoryImpl(AppointmentRemoteDataSource()),
                  ),
                  child: BookAppointmentViewTest(),
                ),
              ),
              child: Text(
                'Book Appointment',
                style: FontManger.whiteBoldFont18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
