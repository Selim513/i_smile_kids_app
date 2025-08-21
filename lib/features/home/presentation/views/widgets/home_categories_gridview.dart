import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/navigator_helper.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/home/data/models/categories_model.dart';

class HomeCategoriesGridView extends StatelessWidget {
  const HomeCategoriesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
          child: GestureDetector(
            onTap: () => NavigatorHelper.push(
              context,
              screen: categorieList[index].view!,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Column(
                spacing: 10.h,
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
          ),
        );
      },
    );
  }
}
