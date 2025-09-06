import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class CustomPrimaryAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomPrimaryAppbar({super.key, this.title, this.leading});
  final String? title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(title ?? "", style: FontManger.blackBoldFont18),
      leading:
          leading ??
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomSecondaryAppbar extends StatelessWidget {
  const CustomSecondaryAppbar({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w, vertical: 20),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          Text(title ?? "", style: FontManger.blackBoldFont18),
        ],
      ),
    );
  }
}
