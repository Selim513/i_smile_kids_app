import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class CustomDashboardAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomDashboardAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.background,
      title: Text(
        'Dashboard',
        style: FontManger.blackBoldFont18.copyWith(color: ColorManager.primary),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
