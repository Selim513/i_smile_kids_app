import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_smile_kids_app/features/reward_points/data/model/redeemed_prize_model.dart'; // Adjust path

class MyPrizesRepository {
  Future<List<RedeemedPrizeModel>> fetchMyPrizes() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final querySnapshot = await FirebaseFirestore.instance
        .collection('redeemed_prizes')
        .where('userId', isEqualTo: user.uid)
        .where('status', isEqualTo: 'pending_claim') // <<< Important Filter
        .orderBy('redeemedAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => RedeemedPrizeModel.fromSnapshot(doc))
        .toList();
  }
}
