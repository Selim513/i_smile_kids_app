import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/features/home/presentation/views/widgets/home_appbar.dart';
import 'package:i_smile_kids_app/features/home/presentation/views/widgets/home_categories_gridview.dart';
import 'package:i_smile_kids_app/features/home/presentation/views/widgets/home_view_header.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            spacing: 10.h,
            children: [
              const HomeAppBar(),
              Gap(5.h),
              const HomeViewHeader(),

              const HomeCategoriesGridView(),
            ],
          ),
        ),
      ),
    );
  }
}
