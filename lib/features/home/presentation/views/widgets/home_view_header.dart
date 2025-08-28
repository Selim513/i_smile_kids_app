import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/home/presentation/views/widgets/home_image_profile.dart';

class HomeViewHeader extends StatefulWidget {
  const HomeViewHeader({super.key});

  @override
  State<HomeViewHeader> createState() => _HomeViewHeaderState();
}

class _HomeViewHeaderState extends State<HomeViewHeader> {
  String? name;
  String? imageUrl;
  @override
  @override
  void initState() {
    super.initState();
    name = FirebaseHelper.user!.displayName;
    imageUrl = FirebaseHelper.user!.photoURL;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPrimaryContainer(
      borderColor: Colors.transparent,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.2),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
      widgets: Column(
        spacing: 10.h,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HomeImageProfileView(imageUrl: imageUrl),
          Text(name ?? '', style: FontManger.primaryFontColorRoboto25),
          Text(
            'We care about your little smile',
            style: FontManger.textFomrHintFont14.copyWith(
              color: ColorManager.warning,
            ),
          ),
        ],
      ),
    );
  }
}
