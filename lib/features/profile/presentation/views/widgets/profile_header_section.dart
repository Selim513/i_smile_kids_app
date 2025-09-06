import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/profile/presentation/views/widgets/profile_image.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({
    super.key,
    required this.imareUrl,
    required this.name,
    required this.email,
  });

  final String? imareUrl;
  final String? name;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return CustomPrimaryContainer(
      widgets: Column(
        children: [
          ProfileImage(image: imareUrl),
          Gap(5.h),
          FittedBox(
            child: Text(
              name ?? 'Name',
              style: FontManger.primaryFontColorRoboto25,
            ),
          ),
          Text(email ?? '', style: FontManger.subTitleTextBold14),
        ],
      ),
    );
  }
}
