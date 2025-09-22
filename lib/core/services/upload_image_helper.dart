import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadProfileImage(String uid, File imageFile) async {
  try {
    final ref = FirebaseStorage.instance
        .ref()
        .child('users')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('$uid.jpg');
    final uploadTask = await ref.putFile(imageFile);
    return await uploadTask.ref.getDownloadURL();
  } catch (e) {
    throw Exception('Failed to Upload image: ${e.toString()}');
  }
}
