import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class CustomPrimaryAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomPrimaryAppbar({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(title ?? "", style: FontManger.blackBoldFont18),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
