import 'dart:io';

import 'package:i_smile_kids_app/core/models/user_models.dart';
import 'package:i_smile_kids_app/features/profile/data/data_source/profile_data_remote_data_source.dart';
import 'package:i_smile_kids_app/features/profile/data/repo/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileDataRemoteDataSource profileRemoteDataSource;

  ProfileRepoImpl(this.profileRemoteDataSource);

  @override
  Future<UserModel?> fetchUserData() async {
    return await profileRemoteDataSource.fetchUserData();
  }

  @override
  Future<void> uploadUserProfile({required File imageFile}) {
    return profileRemoteDataSource.uploadUserProfileImage(imageFile: imageFile);
  }

  @override
  Future<void> profileSaveChanges({required UserModel user}) async {
    return await profileRemoteDataSource.profileSaveChanges(user: user);
  }
}
