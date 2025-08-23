import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/core/models/user_models.dart';

Future<void> saveUserDataToFirestore({
  required String uid,
  required String name,
  required String email,
  required String nationality,
  required String emirateOfResidency,
  required String age,
  String? signinMethod,
  String? photoURL,
}) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'age': age,
      'email': email,
      'nationality': nationality,
      'emirateOfResidency': emirateOfResidency,
      // 'photoURL': photoURL,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  } catch (e) {
    throw Exception('Failed to store data ${e.toString()}');
  }
}

Future<void> updateUserDetails({
  required String uid,
  // required String name,
  String? nationality,
  String? emirateOfResidency,
  String? age,
  String? photoURL,
}) async {
  FirebaseFirestore.instance.collection('users').doc(uid).update({
    'uid': uid,
    // 'name': name,
    'age': age,
    'nationality': nationality,
    'emirateOfResidency': emirateOfResidency,
    // 'photoURL': photoURL,
    'updatedAt': FieldValue.serverTimestamp(),
  });
}

Future<void> updateProfileImag({
  required String uid,
  String? photoURL,
}) async {
  FirebaseFirestore.instance.collection('users').doc(uid).update({
    'uid': uid,
    'photoURL': photoURL,
    'updatedAt': FieldValue.serverTimestamp(),
  });
}

Future<void> updateProileData({
  required String uid,
  String? name,
  String? nationality,
  String? emirateOfResidency,
  String? age,
  String? photoURL,
}) async {
  FirebaseFirestore.instance.collection('users').doc(uid).update({
    'uid': uid,
    'name': name ?? FirebaseHelper.user!.displayName,
    'age': age,
    'nationality': nationality,
    'emirateOfResidency': emirateOfResidency,
    // 'photoURL': photoURL,
    'updatedAt': FieldValue.serverTimestamp(),
  });
}

Future<UserModel?> fetchUserDataFromFirestore(String uid) async {
  try {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists && doc.data() != null) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  } catch (e) {
    throw Exception('Failed to fetch user data: ${e.toString()}');
  }
}
