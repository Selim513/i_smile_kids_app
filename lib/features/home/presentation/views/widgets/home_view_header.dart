
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/asset_helper.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPrimaryContainer(
      widgets: Column(
        spacing: 10.h,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundImage: AssetHelper.assetImage(name: 'logo'),
          ),
          Text(
            'Welcome Ahmed',
            style: FontManger.blackBoldFont18.copyWith(
              fontSize: 22.sp,
            ),
          ),
          Text(
            'We care about your little smile',
            style: FontManger.textFomrHintFont14.copyWith(
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
    );
  }
}
