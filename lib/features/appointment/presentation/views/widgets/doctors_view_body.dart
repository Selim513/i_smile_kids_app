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
      padding: EdgeInsetsGeometry.symmetric(vertical: 15.h, horizontal: 10.w),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => NavigatorHelper.push(
                    context,
                    screen: DoctorsProfileView(),
                  ),
                  child: DoctorsGridViewContainer(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
