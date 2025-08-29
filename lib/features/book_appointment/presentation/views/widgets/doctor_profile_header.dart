import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/models/doctors_model.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/views/widgets/custom_doctor_profile_achivements_container.dart';

class DoctorProfileHeader extends StatelessWidget {
  const DoctorProfileHeader({super.key, required this.docData});
  final DoctorsModel docData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
        gradient: const LinearGradient(
          begin: Alignment(0.00, 0.00),
          end: Alignment(0.00, 1.00),
          colors: [Colors.white, Color(0xFFFCFAFA)],
        ),
      ),
      child: Column(
        spacing: 20.h,
        children: [
          Container(
            height: 110.h,
            width: 110.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(docData.imageUrl),
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.success.withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              shape: BoxShape.circle,
            ),
          ),
          Column(
            spacing: 5.h,
            children: [
              Text(
                'Dr. ${docData.docFullName}',
                textAlign: TextAlign.center,
                style: FontManger.primaryFontColorRoboto25.copyWith(
                  color: ColorManager.success,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                docData.specialization,
                style: FontManger.subTitleTextBold14,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // CustomDoctorProfileAchivementsContainer(
              //   icon: Icons.people,
              //   primaryColor: ColorManager.primary,
              //   title: '1000+',
              //   subTitle: 'Patients',
              // ),
              CustomDoctorProfileAchivementsContainer(
                icon: FontAwesomeIcons.medal,
                primaryColor: ColorManager.success,
                title: '${docData.experienceYears} Yrs',
                subTitle: 'Experience',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
