import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/navigator_helper.dart';
import 'package:i_smile_kids_app/core/services/firebase_brushing_time_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_snack_bar.dart';
import 'package:i_smile_kids_app/features/home/data/models/categories_model.dart';

class HomeCategoriesGridView extends StatefulWidget {
  const HomeCategoriesGridView({super.key});

  @override
  State<HomeCategoriesGridView> createState() => _HomeCategoriesGridViewState();
}

class _HomeCategoriesGridViewState extends State<HomeCategoriesGridView> {
  Future<void> _handleBrushingTimerTap() async {
    final canAccess = await BrushingScheduleManager.canAccessBrushingTimer();

    if (!canAccess) {
      final message = await BrushingScheduleManager.getAccessMessage();
      if (mounted) {
        CustomSnackBar.completedBrushingTime(message, context);
      }

      return;
    }
    if (mounted) {
      NavigatorHelper.push(context, screen: categorieList[1].view!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categorieList.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        var category = categorieList[index];
        return Padding(
          padding: EdgeInsets.all(10.r),
          child: GestureDetector(
            onTap: () {
              if (index == 1) {
                _handleBrushingTimerTap();
              } else {
                NavigatorHelper.push(
                  context,
                  screen: categorieList[index].view!,
                );
              }
            },
            child: FutureBuilder<bool>(
              future: index == 1
                  ? BrushingScheduleManager.canAccessBrushingTimer()
                  : Future.value(true),
              builder: (context, snapshot) {
                final isLocked =
                    index == 1 && snapshot.hasData && !snapshot.data!;

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    color: isLocked
                        ? Colors.grey
                        : categorieList[index].bgColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    spacing: 10.h,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isLocked ? Icons.lock : category.icon,
                        color: Colors.white,
                      ),
                      Text(
                        category.title,
                        style: FontManger.whiteBoldFont20.copyWith(
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (isLocked) ...[
                        Text(
                          'Available 6AM - 7PM',
                          style: FontManger.whiteBoldFont20.copyWith(
                            fontSize: 10.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
