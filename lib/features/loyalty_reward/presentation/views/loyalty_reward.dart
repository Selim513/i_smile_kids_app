import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/loyalty_reward/data/repo/prize_repo.dart';
import 'package:i_smile_kids_app/features/loyalty_reward/presentation/manger/loyalty_reward_cubit.dart';
import 'package:i_smile_kids_app/features/loyalty_reward/presentation/manger/loyalty_reward_state.dart';
import 'package:i_smile_kids_app/features/loyalty_reward/presentation/views/my_prize_view.dart';

class LoyaltyPointsView extends StatefulWidget {
  const LoyaltyPointsView({super.key});

  @override
  State<LoyaltyPointsView> createState() => _LoyaltyPointsViewState();
}

class _LoyaltyPointsViewState extends State<LoyaltyPointsView> {
  int _points = 0;

  @override
  void initState() {
    super.initState();
    _loadPoints();
  }

  Future<void> _loadPoints() async {
    final user = FirebaseHelper.user;
    if (user == null) return;

    final doc = await FirebaseHelper.firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      setState(() {
        _points = data['points'] ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchLoyaltyRewardCubit(LoyaltyRewardRepo())..fetchLoyaltyReward(),
      child: Scaffold(
        appBar: CustomPrimaryAppbar(
          title: 'Loyalty Points',
          action: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPrizeView()),
              );
            },
            icon: Text(
              '🎁 My reward',
              style: FontManger.meduimFontBlack14.copyWith(
                color: ColorManager.success,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10.h),
          child: Column(
            spacing: 15.h,
            children: [
              CustomPrimaryContainer(
                borderColor: Colors.transparent,
                bgColor: ColorManager.primary.withValues(alpha: 0.3),
                widgets: Column(
                  children: [
                    Text(
                      'Your Available Reward ',
                      style: FontManger.primaryFontColorRoboto25.copyWith(
                        color: ColorManager.success,
                      ),
                    ),
                    // Text('🎉', style: TextStyle(fontSize: 30.sp)),
                    const Icon(
                      FontAwesomeIcons.gift,
                      color: ColorManager.warning,
                    ),
                    Gap(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: FontManger.blackBoldFont18.copyWith(
                              color: Colors.blue,
                              fontSize: 22.sp,
                            ),
                            children: [
                              TextSpan(text: '$_points '),
                              TextSpan(
                                text: 'Points',
                                style: FontManger.meduimFontBlack14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlocBuilder<FetchLoyaltyRewardCubit, FetchLoyaltyRewardState>(
                builder: (context, state) {
                  if (state is FetchLoyaltyRewardSuccess) {
                    var rewardList = state.prizeData;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: rewardList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                              vertical: 10.r,
                            ),
                            child: CustomPrimaryContainer(
                              padding: EdgeInsets.all(10.r),
                              borderColor: ColorManager.lightGreyColor,
                              widgets: Column(
                                spacing: 10.h,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 25.r,
                                    backgroundColor: ColorManager.primary,
                                    child: Text(
                                      rewardList[index].icon,
                                      style: TextStyle(fontSize: 30.sp),
                                    ),
                                  ),
                                  Text(
                                    rewardList[index].nameEn,
                                    style: FontManger.blackBoldFont18.copyWith(
                                      color: ColorManager.primary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  Row(
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          style: FontManger.blackBoldFont18
                                              .copyWith(
                                                color: ColorManager.success,
                                              ),
                                          children: [
                                            TextSpan(text: 'Points required :'),
                                            TextSpan(
                                              text:
                                                  " ${rewardList[index].points}",
                                              style: FontManger.blackBoldFont18
                                                  .copyWith(
                                                    color: ColorManager.error,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    rewardList[index].descEn,
                                    textAlign: TextAlign.center,
                                    style: FontManger.meduimFontBlack14
                                        .copyWith(color: ColorManager.textDark),
                                  ),
                                  CustomEleveatedButton(
                                    bgColor: ColorManager.warning,
                                    onPress: () {},
                                    child: Text(
                                      'Redeem Now',
                                      style: FontManger.whiteBoldFont20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is FetchLoyaltyRewardLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(
                      child: Text(
                        'There is an error occured please try again later !.',
                        textAlign: TextAlign.center,
                        style: FontManger.blackBoldFont20.copyWith(
                          color: ColorManager.error,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsetsGeometry.all(20.r),
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         CustomPrimaryContainer(
        //           borderColor: Colors.transparent,
        //           bgColor: ColorManager.primary.withValues(alpha: 0.3),
        //           widgets: Column(
        //             children: [
        //               Text(
        //                 'Your Available Reward ',
        //                 style: FontManger.primaryFontColorRoboto25.copyWith(
        //                   color: ColorManager.success,
        //                 ),
        //               ),
        //               // Text('🎉', style: TextStyle(fontSize: 30.sp)),
        //               const Icon(
        //                 FontAwesomeIcons.gift,
        //                 color: ColorManager.warning,
        //               ),
        //               Gap(10.h),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   RichText(
        //                     text: TextSpan(
        //                       style: FontManger.blackBoldFont18.copyWith(
        //                         color: Colors.blue,
        //                         fontSize: 22.sp,
        //                       ),
        //                       children: [
        //                         TextSpan(text: '$_points '),
        //                         TextSpan(
        //                           text: 'Points',
        //                           style: FontManger.meduimFontBlack14,
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //         Gap(10.h),
        //         const KidsVoucherCard(
        //           placeName: "Kidzania Mall",
        //           offer: "🎢 Free Entry Ticket",
        //           expiryDate: "30 Aug 2025",
        //           image: "assets/images/kidTest.png",
        //         ),
        //         Gap(10.h),
        //         const KidsVoucherCard(
        //           placeName: "mcdonald's",
        //           offer: "Free Happy Meal",
        //           expiryDate: "30 Aug 2025",
        //           image: "assets/images/kidTest2.png",
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
