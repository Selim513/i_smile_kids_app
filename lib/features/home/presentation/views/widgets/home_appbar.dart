import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Text('Home', style: FontManger.blackBoldFont18),
        Spacer(),
        Row(
          spacing: 5.w,
          children: [
            Icon(FontAwesomeIcons.bell, color: ColorManager.primary),
            // CircleAvatar(
            //   radius: 20.r,
            //   backgroundImage: AssetHelper.assetImage(name: 'logo'),
            // ),
          ],
        ),
      ],
    );
  }
}
