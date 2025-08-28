import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/navigator_helper.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/doctors_profile_view.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/doctors_gridview_container.dart';

class DoctorsViewBody extends StatelessWidget {
  const DoctorsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: 5,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.w,
                mainAxisSpacing: 5.h,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => NavigatorHelper.push(
                    context,
                    screen: const DoctorsProfileView(),
                  ),
                  child: const DoctorsGridViewContainer(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
