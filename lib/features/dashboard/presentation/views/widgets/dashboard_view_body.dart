
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/widgets/dashboard_header.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/widgets/dashboard_patient_appointment_container.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardHeader(),
          Gap(10.h),
          Divider(color: ColorManager.lightGreyColor),
          Gap(15.h),
    
          Text(
            'Appointments Requests',
            style: FontManger.blackBoldFont20.copyWith(
              color: ColorManager.success,
            ),
          ),
          Gap(5.h),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 5.h),
                  child: CustomPrimaryContainer(
                    padding: EdgeInsets.all(10.r),
                    widgets: Column(
                      spacing: 10.h,
                      children: [
                        DashboardPatientAppointmentContainer(),
    
                        Row(
                          spacing: 10.w,
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              color: ColorManager.primary,
                            ),
                            Text(
                              'Tomorrow, 10:30 AM',
                              style: FontManger.regularFontBlack12,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomEleveatedButton(
                                height: 30.h,
    
                                onPress: () {},
                                bgColor: ColorManager.success,
                                child: Text(
                                  'Complete',
                                  style: FontManger.whiteBoldFont20.copyWith(
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),
                            Gap(10.w),
    
                            Expanded(
                              child: CustomEleveatedButton(
                                height: 30.h,
    
                                onPress: () {},
                                bgColor: ColorManager.error,
                                child: Text(
                                  'No Show',
                                  style: FontManger.whiteBoldFont20.copyWith(
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),
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
  }
}
