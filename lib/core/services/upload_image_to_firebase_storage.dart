// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// Future<void> uploadImage({required String imagePath}) async {
//   final storageRef = FirebaseStorage.instance
//       .ref()
//       .child('profile_images')
//       .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');

//   await storageRef.putFile(File(imagePath));
//   final imageUrl = await storageRef.getDownloadURL();
// }
