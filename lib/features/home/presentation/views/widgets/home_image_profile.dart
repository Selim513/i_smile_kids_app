
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/asset_helper.dart';

class HomeImageProfileView extends StatelessWidget {
  const HomeImageProfileView({super.key, required this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50.r,
      backgroundImage: imageUrl == null
          ? AssetHelper.assetImage(name: 'boy')
          : NetworkImage(imageUrl!),
    );
  }
}
