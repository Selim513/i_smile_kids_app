import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/home/presentation/views/widgets/home_image_profile.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/fetch_profile_data_cubit/fetch_profile_data_cubit.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/fetch_profile_data_cubit/fetch_profile_data_state.dart';

class HomeViewHeader extends StatefulWidget {
  const HomeViewHeader({super.key});

  @override
  State<HomeViewHeader> createState() => _HomeViewHeaderState();
}

class _HomeViewHeaderState extends State<HomeViewHeader> {
  @override
  void initState() {
    super.initState();
    context.read<FetchProfileDataCubit>().fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchProfileDataCubit, FetchProfileDataCubitState>(
      builder: (context, state) {
        if (state is FetchProfileDataSuccess) {
          var userData = state.userData;
          return CustomPrimaryContainer(
            borderColor: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            widgets: Column(
              spacing: 10.h,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeImageProfileView(
                  imageUrl: userData.photoURL,
                  //  imageUrl
                ),
                Text(
                  // name
                  userData.name,
                  style: FontManger.primaryFontColorRoboto25,
                ),
                Text(
                  'We care about your little smile',
                  style: FontManger.textFomrHintFont14.copyWith(
                    color: ColorManager.warning,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Text('There is an error occured Please try again later !'),
          );
        }
      },
    );
  }
}
