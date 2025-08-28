import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/helper/asset_helper.dart';
import 'package:i_smile_kids_app/core/helper/navigator_helper.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/doctors_view.dart';
import 'package:i_smile_kids_app/features/visit_time/presentation/manger/fetch_next_visit_details_cubit.dart';
import 'package:i_smile_kids_app/features/visit_time/presentation/manger/fetch_next_visit_details_state.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class NextVisitTimeViewBody extends StatefulWidget {
  const NextVisitTimeViewBody({super.key});

  @override
  State<NextVisitTimeViewBody> createState() => _NextVisitTimeViewBodyState();
}

class _NextVisitTimeViewBodyState extends State<NextVisitTimeViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<FetchNextVisitDetailsCubit>().fetchNextVisitDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child:
            BlocBuilder<
              FetchNextVisitDetailsCubit,
              FetchNextVisitDetailsCubitState
            >(
              builder: (context, state) {
                if (state is FetchNextVisitDetailsSuccess) {
                  var data = state.data;
                  final dateText = DateFormat(
                    'EEEE, MMMM d',
                  ).format(data.appointmentDate);
                  final timeText = DateFormat(
                    'hh:mm a',
                  ).format(data.appointmentDate);
                  return Column(
                    children: [
                      CustomPrimaryContainer(
                        widgets: Column(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200.w,
                              height: 150.h,
                              child: AssetHelper.imageAsset(name: 'boy1'),
                            ),
                            Text(
                              data.patientName,
                              style: FontManger.balsamiqSansFontBold20,
                            ),
                            Text(
                              dateText,
                              // 'Tuesday, October 26',
                              textAlign: TextAlign.center,
                              style: FontManger.balsamiqSansFontBold20.copyWith(
                                fontSize: 50.sp,
                                color: ColorManager.warning,
                              ),
                            ),
                            Text(
                              timeText,
                              textAlign: TextAlign.center,
                              style: FontManger.balsamiqSansFontBold20.copyWith(
                                fontSize: 50.sp,
                                color: ColorManager.warning,
                              ),
                            ),
                            Text(
                              'We can\'t wait to see your bright smile!',
                              textAlign: TextAlign.center,
                              style: FontManger.meduimFontBlack14.copyWith(
                                color: ColorManager.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(20.h),
                      CustomEleveatedButton(
                        bgColor: ColorManager.error,
                        onPress: () {
                          context
                              .read<FetchNextVisitDetailsCubit>()
                              .cancelAppointment(state.data.id);
                          setState(() {});
                        },
                        child: Text(
                          'Canncle',
                          style: FontManger.whiteBoldFont20,
                        ),
                      ),
                    ],
                  );
                } else if (state is FetchNextVisitDetailsFailure) {
                  return Column(
                    spacing: 30.h,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.errMessage,
                        textAlign: TextAlign.center,
                        style: FontManger.primaryFontColorRoboto25.copyWith(
                          color: ColorManager.secondary,
                        ),
                      ),
                      Lottie.asset('assets/json/no_appointment.json'),

                      Text(
                        'We can\'t wait to see your bright smile!',
                        textAlign: TextAlign.center,

                        style: FontManger.subTitleTextBold14,
                      ),

                      CustomEleveatedButton(
                        bgColor: ColorManager.primary,
                        onPress: () {
                          NavigatorHelper.push(context, screen: const DoctorsVeiw());
                        },
                        child: Text(
                          'Book Now',
                          style: FontManger.whiteBoldFont20,
                        ),
                      ),
                    ],
                  );
                } else if (state is AppointmentCanncle) {
                  return Center(
                    child: Text(
                      'Your appointment has been successfully cancelled.',
                      textAlign: TextAlign.center,
                      style: FontManger.balsamiqSansFontBold20.copyWith(
                        color: ColorManager.error,
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
      ),
    );
  }
}
