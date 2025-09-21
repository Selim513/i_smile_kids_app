import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/dashboard/data/models/dashboard_appointment_model.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/manger/dashboard_cubit.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/manger/dashboard_state.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/widgets/dashboard_header.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/widgets/dashboard_patient_appointment_container.dart';

class DashboardViewBody extends StatefulWidget {
  const DashboardViewBody({super.key});

  @override
  State<DashboardViewBody> createState() => _DashboardViewBodyState();
}

class _DashboardViewBodyState extends State<DashboardViewBody> {
  int? todayAppointmentCount;
  int? appointmentCount;
  List<DashboardAppointment>? userData;
  late String doctorId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(15.r),
      child: BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {
          if (state is DashboardLoaded) {
            setState(() {
              doctorId = '0EXfftpQWGLTr3rokL4R';
              userData = state.allAppointment;
              appointmentCount = state.allAppointment.length;
              todayAppointmentCount = state.todayAppointments.length;
            });
          }
        },
        builder: (context, state) {
          if (state is DashboardLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                context.read<DashboardCubit>().loadDashboard();
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardHeader(appointmentCount: todayAppointmentCount ?? 0),
                Gap(10.h),
                Divider(color: ColorManager.lightGreyColor),
                Gap(15.h),

                Text(
                  'Appointments Requests',
                  style: FontManger.blackBoldFont18.copyWith(
                    fontSize: 20.sp,
                    color: ColorManager.success,
                  ),
                ),
                Gap(5.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: appointmentCount ?? 0,

                    itemBuilder: (context, index) {
                      var data = userData?[index];
                      // data.time
                      return Padding(
                        padding: EdgeInsetsGeometry.symmetric(vertical: 5.h),
                        child: CustomPrimaryContainer(
                          padding: EdgeInsets.all(10.r),
                          widgets: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10.h,
                            children: [
                              DashboardPatientAppointmentContainer(
                                name: data!.patientName,
                                age: data.patientDetails.age,
                                status: data.status,
                                profileImage: data.patientDetails.profileImage??'',
                              ),
                              Text(data.patientDetails.problem,style: FontManger.subTitleTextBold14,),

                              //.....Time
                              Row(
                                spacing: 10.w,
                                children: [
                                  Icon(
                                    Icons.date_range_rounded,
                                    color: ColorManager.primary,
                                  ),
                                  Text(
                                    data.date,

                                    // 'Tomorrow, 10:30 AM',
                                    style: FontManger.regularFontBlack12,
                                  ),
                                  Gap(30.w),
                                  Icon(
                                    Icons.access_time_rounded,
                                    color: ColorManager.primary,
                                  ),
                                  Text(
                                    data.time,

                                    // 'Tomorrow, 10:30 AM',
                                    style: FontManger.regularFontBlack12,
                                  ),
                                ],
                              ),
                              //....Buttons
                              Row(
                                spacing: 5.w,
                                children: [
                                  Expanded(
                                    child: CustomEleveatedButton(
                                      height: 30.h,

                                      onPress: () {
                                        context
                                            .read<DashboardCubit>()
                                            .markAppointmentCompleted(
                                              appointmentId: data.id,
                                              notes: '',
                                            );
                                        print('Doneeeeeeee');
                                      },
                                      bgColor: ColorManager.success,
                                      child: Text(
                                        'Complete',
                                        style: FontManger.whiteBoldFont20
                                            .copyWith(fontSize: 15.sp),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomEleveatedButton(
                                      height: 30.h,

                                      onPress: () {
                                        context
                                            .read<DashboardCubit>()
                                            .cancelAppointment(
                                              appointmentId: data.id,
                                              reason: 'Missed',
                                              date: DateTime.now().toString(),
                                              doctorId: doctorId,
                                              time: DateTime.now().hour
                                                  .toString(),
                                            );
                                      },
                                      bgColor: ColorManager.error,
                                      child: Text(
                                        'cancel',
                                        style: FontManger.whiteBoldFont20
                                            .copyWith(fontSize: 15.sp),
                                      ),
                                    ),
                                  ),
                                  // Gap(10.w),

                                  // Expanded(
                                  //   child: CustomEleveatedButton(
                                  //     height: 30.h,

                                  //     onPress: () {},
                                  //     bgColor: ColorManager.error,
                                  //     child: Text(
                                  //       'Remove',
                                  //       style: FontManger.whiteBoldFont20
                                  //           .copyWith(fontSize: 15.sp),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
