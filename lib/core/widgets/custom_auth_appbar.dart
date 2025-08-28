import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class CustomAuthAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAuthAppbar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: ColorManager.background,
      backgroundColor: ColorManager.secondary,
      elevation: 1,
      centerTitle: true,
      title: Text(
        title,
        style: FontManger.primaryFontColorRoboto25.copyWith(
          color: ColorManager.background,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
