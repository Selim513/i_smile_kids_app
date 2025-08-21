import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/prfoile/presentation/views/widgets/profile_view_body.dart';

class ProfileViews extends StatelessWidget {
  const ProfileViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.secondary,
        centerTitle: true,
        title: Text('Profile', style: FontManger.whiteBoldFont18),
      ),
      body: ProfileViewBody(),
    );
  }
}
