import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';

Future<String> uploadProfileImage(String uid, File imageFile) async {
  try {
    final ref = FirebaseStorage.instance
        .ref()
        .child('users')
        .child(FirebaseHelper.user!.uid)
        .child('$uid.jpg');
    final uploadTask = await ref.putFile(imageFile);
    return await uploadTask.ref.getDownloadURL();
  } catch (e) {
    throw Exception('Failed to Upload image: ${e.toString()}');
  }
}
