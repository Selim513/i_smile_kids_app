import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/reward_points/data/repo/my_prize_model.dart';
import 'package:i_smile_kids_app/features/reward_points/presentation/manger/my-prize-cubit/my_prize_cubit.dart';
import 'package:i_smile_kids_app/features/reward_points/presentation/manger/my-prize-cubit/my_prize_state.dart';

class MyPrizeView extends StatelessWidget {
  const MyPrizeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyPrizesCubit(MyPrizesRepository())..loadMyPrizes(),
      child: Scaffold(
        appBar: CustomPrimaryAppbar(title: 'My Rewards'),
        body: BlocBuilder<MyPrizesCubit, MyPrizesState>(
          builder: (context, state) {
            if (state is MyPrizesLoading || state is MyPrizesInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyPrizesError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is MyPrizesLoaded) {
              if (state.prizes.isEmpty) {
                return Center(
                  child: Text(
                    'You have no pending prizes to collect!',
                    style: FontManger.meduimFontBlack14,
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(10.r),
                itemCount: state.prizes.length,
                itemBuilder: (context, index) {
                  final prize = state.prizes[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: CustomPrimaryContainer(
                      widgets: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Awesome! You used ${prize.pointsSpent} of your points to get this prize! 🎉',
                            textAlign: TextAlign.center,
                            style: FontManger.primaryFontColorRoboto25,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            prize.prizeIcon,
                            style: TextStyle(fontSize: 40.sp),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            prize.prizeName,
                            textAlign: TextAlign.center,
                            style: FontManger.blackBoldFont18.copyWith(
                              color: ColorManager.success,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            prize.prizeDescription,
                            textAlign: TextAlign.center,
                            style: FontManger.meduimFontBlack14,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Please Wait we will accept your req Visit the clinic to collect your prize, or give us a quick call ! 📞',
                            textAlign: TextAlign.center,
                            style: FontManger.subTitleTextBold14,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
