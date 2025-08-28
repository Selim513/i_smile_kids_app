import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/asset_helper.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/auth_view_buttons_widget.dart';

class AuthViewBody extends StatelessWidget {
  const AuthViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 15.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AssetHelper.imageAsset(
            name: 'logo',
            height: 300.h,
            boxFit: BoxFit.cover,
          ),
          const AuthButtonsWidget(),
        ],
      ),
    );
  }
}
