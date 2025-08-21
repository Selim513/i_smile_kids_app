import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/reward_points/presentation/views/widgets/kids_voucher_card.dart';

class LoyaltyPointsView extends StatelessWidget {
  const LoyaltyPointsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPrimaryAppbar(title: 'Loyalty Points'),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomPrimaryContainer(
                borderColor: Colors.transparent,
                bgColor: ColorManager.primary.withValues(alpha: 0.3),
                widgets: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Your Available Reward ',
                      style: FontManger.primaryFontColorRoboto25.copyWith(
                        color: ColorManager.success,
                      ),
                    ),
                    // Text('🎉', style: TextStyle(fontSize: 30.sp)),
                    Icon(FontAwesomeIcons.gift, color: ColorManager.warning),
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
                              TextSpan(text: '2500 '),
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
              Gap(10.h),
              KidsVoucherCard(
                placeName: "Kidzania Mall",
                offer: "🎢 Free Entry Ticket",
                expiryDate: "30 Aug 2025",
                image: "assets/images/kidTest.png",
              ),
              Gap(10.h),
              KidsVoucherCard(
                placeName: "mcdonald's",
                offer: "Free Happy Meal",
                expiryDate: "30 Aug 2025",
                image: "assets/images/kidTest2.png",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
