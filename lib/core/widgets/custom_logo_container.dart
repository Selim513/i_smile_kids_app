import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/asset_helper.dart';

class CustomLogoContainer extends StatelessWidget {
  const CustomLogoContainer({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 150.h,
      decoration: BoxDecoration(
        // color: Colors.green,
        image: DecorationImage(image: AssetHelper.assetImage(name: 'logo1')),
      ),
    );
  }
}
