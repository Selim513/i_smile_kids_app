import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';

class MyPrizeView extends StatelessWidget {
  const MyPrizeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPrimaryAppbar(title: 'My Reward'),
      body: Padding(
        padding: EdgeInsetsGeometry.all(10.r),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 5.h),
              child: CustomPrimaryContainer(
                widgets: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10.h,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Awesome! You used 50 of your points to get this prize! 🎉',
                      textAlign: TextAlign.center,
                      style: FontManger.primaryFontColorRoboto25,
                    ),
                    Text('🎁', style: TextStyle(fontSize: 40.sp)),
                    Text(
                      'Prize Name',
                      style: FontManger.blackBoldFont18.copyWith(
                        color: ColorManager.success,
                      ),
                    ),
                    Text(
                      'A creative coloring book with tooth-friendly characters and fun activities.',
                      textAlign: TextAlign.center,
                      style: FontManger.meduimFontBlack14,
                    ),
                    Text(
                      'Visit the clinic to collect your prize, or give us a quick call ! 📞',
                      textAlign: TextAlign.center,
                      style: FontManger.subTitleTextBold14,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
