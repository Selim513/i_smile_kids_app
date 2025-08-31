import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class DoctorsGridViewContainer extends StatelessWidget {
  const DoctorsGridViewContainer({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.specialization,
  });
  final String name;
  final String imageUrl;
  final String specialization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(10.r),
      child: Container(
        padding: EdgeInsetsGeometry.symmetric(vertical: 10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 60,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          spacing: 10.h,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 75.w,
                fit: BoxFit.cover,

                height: 75.h,
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(color: ColorManager.primary),
                ),
              ),
            ),

            Text(
              'Dr. $name',
              style: FontManger.regularFontBlack12.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorManager.secondary,
              ),
            ),
            Text(
              specialization,
              style: FontManger.regularFontBlack12.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorManager.success,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
