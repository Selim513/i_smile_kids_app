import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/services/firebase_brushing_time_manger.dart';
import 'package:i_smile_kids_app/features/home/presentation/views/widgets/home_appbar.dart';
import 'package:i_smile_kids_app/features/home/presentation/views/widgets/home_categories_gridview.dart';
import 'package:i_smile_kids_app/features/home/presentation/views/widgets/home_view_header.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/fetch_profile_data_cubit/fetch_profile_data_cubit.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    BrushingScheduleManager.canAccessBrushingTimer();
    // context.read<FetchProfileDataCubit>().fetchProfileData(
    //   userId: FirebaseAuth.instance.currentUser!.uid,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        key: _refreshKey,
        onRefresh: () async {
          setState(() {
            context.read<FetchProfileDataCubit>().fetchProfileData(
              userId: FirebaseAuth.instance.currentUser!.uid,
            );
          });
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
      ),
    );
  }
}
