import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/fetch_profile_data_cubit/fetch_profile_data_cubit.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/fetch_profile_data_cubit/fetch_profile_data_state.dart';
import 'package:i_smile_kids_app/features/profile/presentation/views/widgets/custom_profile_personal_details_row.dart';

class ProfileUserPersonalDetailsSection extends StatelessWidget {
  const ProfileUserPersonalDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchProfileDataCubit, FetchProfileDataCubitState>(
      builder: (context, state) {
        if (state is FetchProfileDataSuccess) {
          var userData = state.userData;
          return Column(
            spacing: 10.h,
            children: [
              CustomPrimaryContainer(
                widgets: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.h,
                  children: [
                    Text('Personal Details', style: FontManger.blackBoldFont18),
                    CustomProfilePersonalDetailsRow(
                      title: 'Nationality',
                      value: userData.nationality,
                    ),
                    CustomProfilePersonalDetailsRow(
                      title: 'Age',
                      value: userData.age,
                    ),
                    CustomProfilePersonalDetailsRow(
                      title: 'Emirates Residency',
                      value: userData.emirateOfResidency,
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is FetchProfileDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FetchProfileDataFailure) {
          return Center(
            child: Text(
              state.errMessage,
              textAlign: TextAlign.center,
              style: FontManger.primaryFontColorRoboto25.copyWith(
                color: ColorManager.error,
              ),
            ),
          );
        } else {
          return Center(
            child: Text(
              'Please check your internet and try again !',
              textAlign: TextAlign.center,
              style: FontManger.primaryFontColorRoboto25.copyWith(
                color: ColorManager.error,
              ),
            ),
          );
        }
      },
    );
  }
}
