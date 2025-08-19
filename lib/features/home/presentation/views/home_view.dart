import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/home/data/models/categories_model.dart';
import 'package:i_smile_kids_app/features/home/presentation/views/widgets/home_appbar.dart';
import 'package:i_smile_kids_app/features/home/presentation/views/widgets/home_view_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            spacing: 10.h,
            children: [
              HomeAppBar(),
              Gap(20.h),
              HomeViewHeader(),

              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: categorieList.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  var category = categorieList[index];
                  return Padding(
                    padding: EdgeInsetsGeometry.all(5.r),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(category.icon, color: Colors.white),
                          Text(
                            category.title,
                            style: FontManger.whiteBoldFont18,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
