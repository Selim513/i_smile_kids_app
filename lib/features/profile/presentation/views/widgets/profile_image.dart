import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_snack_bar.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/upload_image_cubit/upload_profile_image_cubit.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/upload_image_cubit/upload_profile_image_state.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.image});
  final String? image;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      UploadPickedProfileImageCubit,
      UploadPickedProfileImageState
    >(
      listener: (context, state) {
        if (state is PickImageFailure) {
          CustomSnackBar.errorSnackBar(state.errMessage, context);
        } else if (state is PickImageSuccess) {
          CustomSnackBar.successSnackBar(state.succMessage!, context);
        }
      },
      builder: (context, state) {
        final cubit = context.read<UploadPickedProfileImageCubit>();
        return InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return SafeArea(
                  child: Wrap(
                    children: [
                      ListTile(
                        leading: Icon(Icons.photo_library),
                        title: Text("Gallery"),
                        onTap: () {
                          cubit.pickImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.camera_alt),
                        title: Text("Camera"),
                        onTap: () {
                          cubit.pickImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: state is PickImageLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.secondary,
                  ),
                )
              : CircleAvatar(
                  radius: 50.r,
                  backgroundColor: const Color.fromRGBO(229, 231, 235, 1),
                  child: cubit.pickedImage != null
                      ? ClipOval(
                          child: Image.file(
                            cubit.pickedImage!,
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                        )
                      : (image != null && image!.isNotEmpty)
                      ? ClipOval(
                          child: Image.network(
                            image!,
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              );
                            },
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.grey),
                            Text(
                              'Add photo',
                              style: FontManger.regularFontBlack12.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                ),
        );
      },
    );
  }
}
