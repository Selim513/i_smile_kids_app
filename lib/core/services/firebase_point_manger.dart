
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';

Future<void> addPoints(int points) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

  await FirebaseFirestore.instance.runTransaction((transaction) async {
    final snapshot = await transaction.get(userRef);

    if (!snapshot.exists) return;

    int currentPoints = snapshot['points'] ?? 0;
    transaction.update(userRef, {
      'points': currentPoints + points,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  });
}

//--------------
Future<int> getUserPoints() async {
  final user = FirebaseHelper.user;
  if (user == null) return 0;

  final doc = await FirebaseHelper.firebaseFirestore
      .collection('users')
      .doc(user.uid)
      .get();

  if (doc.exists) {
    final data = doc.data() as Map<String, dynamic>;
    return data['points'] ?? 0;
  }
  return 0;
}
