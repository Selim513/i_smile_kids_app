import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/asset_helper.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';

class NextVisitTimeViewBody extends StatelessWidget {
  const NextVisitTimeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(20.r),
      child: CustomPrimaryContainer(
        widgets: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.w,
              height: 150.h,
              child: AssetHelper.imageAsset(name: 'boy1'),
            ),
            Text('Hello Ahmed', style: FontManger.balsamiqSansFontBold20),
            Text(
              'Tuesday, October 26',
              textAlign: TextAlign.center,
              style: FontManger.balsamiqSansFontBold20.copyWith(
                fontSize: 50.sp,
                color: ColorManager.warning,
              ),
            ),
            Text(
              '10:30 AM',
              textAlign: TextAlign.center,
              style: FontManger.balsamiqSansFontBold20.copyWith(
                fontSize: 50.sp,
                color: ColorManager.warning,
              ),
            ),
            Text(
              'We can\'t wait to see your bright smile!',
              style: FontManger.meduimFontBlack14.copyWith(
                color: ColorManager.success,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
