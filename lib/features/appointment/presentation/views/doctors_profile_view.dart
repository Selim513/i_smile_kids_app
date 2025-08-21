import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/docotr_profile_body.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/doctor_profile_header.dart';

class DoctorsProfileView extends StatelessWidget {
  const DoctorsProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPrimaryAppbar(),
      body: CustomScrollView(
        // spacing: 15.h,
        slivers: [
          SliverToBoxAdapter(child: DoctorProfileHeader()),
          SliverToBoxAdapter(child: Gap(20.h)),
          SliverToBoxAdapter(child: DoctorProfileBody()),
        ],
      ),
    );
  }
}
