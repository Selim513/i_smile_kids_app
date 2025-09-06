import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/navigator_helper.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/manger/fetch_doctors_data_cubit/fetch_doctors_data_cubit.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/manger/fetch_doctors_data_cubit/fetch_doctors_data_state.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/views/doctors_profile_view.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/views/widgets/doctors_gridview_container.dart';

class DoctorsViewBody extends StatelessWidget {
  const DoctorsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
      child: BlocBuilder<FetchDoctorsDataCubit, FetchDoctorsDataState>(
        builder: (context, state) {
          if (state is FetchDoctorsDataSuccess) {
            var dataList = state.data;

            return GridView.builder(
              itemCount: dataList.length,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.w,
                mainAxisSpacing: 5.h,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                var docData = dataList[index];
                return GestureDetector(
                  onTap: () => NavigatorHelper.push(
                    context,
                    screen: DoctorsProfileView(docData: docData),
                  ),
                  child: DoctorsGridViewContainer(
                    imageUrl: docData.imageUrl,
                    name: docData.docName,
                    specialization: docData.specialization,
                  ),
                );
              },
            );
          } else if (state is FetchDoctorsDataFailure) {
            return Center(child: Text(state.errMessage));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
