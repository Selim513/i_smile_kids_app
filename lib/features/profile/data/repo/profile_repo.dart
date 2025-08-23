import 'dart:io';

import 'package:i_smile_kids_app/core/models/user_models.dart';

abstract class ProfileRepo {
  Future<UserModel?> fetchUserData();
  Future<void> uploadUserProfile({required File imageFile});
  Future<void> profileSaveChanges({required UserModel user});
}
