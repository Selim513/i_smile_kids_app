import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/services/service_locator.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/data/repo/dental_care_tips_repo_impl.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/presentation/manger/fetch_dental_care_tips_cubit.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/presentation/manger/fetch_dental_care_tips_state.dart';
import 'package:readmore/readmore.dart';

class DentalCareTipsView extends StatelessWidget {
  const DentalCareTipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchDentalCareTipsCubit(getIt.get<DentalCareTipsRepoImpl>())
            ..fetchDentalCareTipsData(),
      child: Scaffold(
        appBar: const CustomPrimaryAppbar(
          title: 'Dental Care Tips',
          leading: SizedBox(),
        ),
        body: Column(
          children: [
            BlocBuilder<FetchDentalCareTipsCubit, FetchDentalCareTipsState>(
              builder: (context, state) {
                if (state is FetchDentalCareTipsSuccess) {
                  var data = state.tips;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var dentalTips = data[index];
                        return Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            horizontal: 20.r,
                            vertical: 5.h,
                          ),
                          child: CustomPrimaryContainer(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            widgets: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  spacing: 10.w,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  
                                    Text(
                                      dentalTips.icon ?? '',
                                      style: TextStyle(fontSize: 30.sp),
                                    ),
                                    Expanded(
                                      child: Column(
                                        spacing: 5,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dentalTips.titleEn ?? '',
                                            style: FontManger.blackBoldFont18,
                                          ),
                                          GestureDetector(
                                            child: ReadMoreText(
                                              dentalTips.bodyEn ?? '',
                                              style:
                                                  FontManger.subTitleTextBold14,
                                              trimMode: TrimMode.Line,
                                              trimLines: 3,
                                              colorClickableText:
                                                  ColorManager.primary,
                                              trimCollapsedText: 'Show more',
                                            ),
                                          ),
                                        ],
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
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
