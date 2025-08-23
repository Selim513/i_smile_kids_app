import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/profile/data/repo/profile_repo_impl.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/upload_image_cubit/upload_profile_image_state.dart';
import 'package:image_picker/image_picker.dart';

class UploadPickedProfileImageCubit
    extends Cubit<UploadPickedProfileImageState> {
  final ProfileRepoImpl repo;

  UploadPickedProfileImageCubit(this.repo) : super(PickProfileImageInitial());
  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      emit(PickImageLoading());
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 75,
      );
      if (pickedFile != null) {
        pickedImage = File(pickedFile.path);
        await repo.uploadUserProfile(imageFile: pickedImage!);
        emit(
          PickImageSuccess(
            succMessage: '✅ Profile image uploaded successfully',
            imagePath: pickedFile.path,
          ),
        );
      } else {
        emit(PickImageFailure(errMessage: "No image selected"));
      }
    } catch (e) {
      emit(PickImageFailure(errMessage: e.toString()));
    }
  }
}
