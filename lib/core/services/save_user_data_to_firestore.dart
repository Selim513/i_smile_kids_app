import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveUserDataToFirestore({
  required String uid,
  required String name,
  required String email,
  required String nationality,
  required String emirateOfResidency,
  required String age,
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
      'photoURL': photoURL,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  } catch (e) {
    throw Exception('Failed to store data ${e.toString()}');
  }
}
