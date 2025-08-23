import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/models/user_models.dart';
import 'package:i_smile_kids_app/core/services/firebase_firestore_data_helper.dart';
import 'package:i_smile_kids_app/core/services/service_locator.dart';
import 'package:i_smile_kids_app/core/services/upload_image_helper.dart';

abstract class ProfileDataRemoteDataSource {
  Future<UserModel?> fetchUserData();
  Future<void> uploadUserProfileImage({required File imageFile});
  Future<void> profileSaveChanges({required UserModel user});
}

class FetchProfileDataRemoteDataSourceImpl extends ProfileDataRemoteDataSource {
  final User user = getIt.get<User>();

  @override
  Future<UserModel?> fetchUserData() async {
    debugPrint('----------user uid: ${user.uid}');
    return await fetchUserDataFromFirestore(user.uid);
  }

  @override
  Future<void> uploadUserProfileImage({required File imageFile}) async {
    try {
      final imageUrl = await uploadProfileImage(user.uid, imageFile);
      await updateProfileImag(uid: user.uid, photoURL: imageUrl);
      await user.updatePhotoURL(imageUrl);
      debugPrint("✅ Profile image uploaded successfully");
    } on Exception catch (e) {
      debugPrint("❌ Error uploading profile image: $e");
      throw Exception('❌ Error uploading profile image: $e');
    }
  }

  @override
  Future<void> profileSaveChanges({required UserModel user}) async {
    try {
      // 🟢 تحديث البيانات في Firestore
      await updateProileData(
        uid: user.uid,
        name: user.name,
        photoURL: user.photoURL,
        age: user.age,
        emirateOfResidency: user.emirateOfResidency,
        nationality: user.nationality,
      );

      // 🟢 كمان ممكن تحدث الـ displayName / photoURL في FirebaseAuth نفسه
      await this.user.updateDisplayName(user.name);
      if (user.photoURL != null && user.photoURL!.isNotEmpty) {
        await this.user.updatePhotoURL(user.photoURL);
      }

      debugPrint("✅ Profile data updated successfully");
    } catch (e) {
      debugPrint("❌ Error saving profile data: $e");
      throw Exception("Error saving profile data: $e");
    }
  }
}
