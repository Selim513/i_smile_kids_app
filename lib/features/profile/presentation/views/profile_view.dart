import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/core/services/service_locator.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/profile/data/repo/profile_repo_impl.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/fetch_profile_data_cubit/fetch_profile_data_cubit.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/upload_image_cubit/upload_profile_image_cubit.dart';
import 'package:i_smile_kids_app/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.secondary,
        centerTitle: true,
        title: Text('Profile', style: FontManger.whiteBoldFont20),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                FetchProfileDataCubit(getIt.get<ProfileRepoImpl>()),
          ),
          BlocProvider(
            create: (context) =>
                UploadPickedProfileImageCubit(getIt.get<ProfileRepoImpl>()),
          ),
        ],

        child: const ProfileViewBody(),
      ),
    );
  }
}

      //  BlocProvider(
      //   create: (context) =>
      //       FetchProfileDataCubit(getIt.get<ProfileRepoImpl>())
      //         ..fetchProfileData(),

      //   child: ProfileViewBody(),
      // ),