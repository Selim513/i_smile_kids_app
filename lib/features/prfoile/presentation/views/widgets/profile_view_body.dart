
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_drop_down_field.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_container.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/create_account_pick_profile_image.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/custom_textform_field.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPrimaryContainer(
            widgets: Column(
              spacing: 20.h,
              children: [
                CreateAccountPickProfileImage(),
                CustomTextFormField(readOnly: true, title: 'Name'),
                ChildAgeDropDownFormField(
                  controller: TextEditingController(),
                ),
                CustomNationalityTextFormField(
                  controller: TextEditingController(),
                ),
                CustomEmirateOfResidencyDropDownTextFormField(
                  controller: TextEditingController(),
                ),
                CustomEleveatedButton(
                  onPress: () {},
                  child: Text(
                    'Save Changes',
                    style: FontManger.whiteBoldFont18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
