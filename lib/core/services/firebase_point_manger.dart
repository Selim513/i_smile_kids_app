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
  final user = FirebaseAuth.instance.currentUser;
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

//---- Daily Reward
/// Daily 5pts reward
// Future<void> giveDailyReward(BuildContext) async {
//   final uid = FirebaseAuth.instance.currentUser?.uid;
//   if (uid == null) return;

//   final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

//   await FirebaseFirestore.instance.runTransaction((transaction) async {
//     final snapshot = await transaction.get(userRef);

//     if (!snapshot.exists) return;

//     final data = snapshot.data() as Map<String, dynamic>;

//     int currentPoints = data['points'] ?? 0;
//     Timestamp? lastReward = data['lastDailyReward'];

//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day); // اليوم الحالي

//     bool canReward = true;

//     if (lastReward != null) {
//       final lastRewardDate = lastReward.toDate();
//       final lastDay = DateTime(
//         lastRewardDate.year,
//         lastRewardDate.month,
//         lastRewardDate.day,
//       );

//       // لو آخر مكافأة كانت نفس اليوم → ممنوع
//       if (lastDay == today) {
//         canReward = false;
//       }
//     }

//     if (canReward) {
//       transaction.update(userRef, {
//         'points': currentPoints + 5,
//         'lastDailyReward': Timestamp.fromDate(today),
//       });
//       CustomSnackBar.successSnackBar(
//         'Thanks for logging in! You just received 5 points for your daily login.',
//         context,
//       );
//     }
//   });
// }
Future<bool> giveDailyReward() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return false;

  final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

  bool rewardGiven = false;

  await FirebaseFirestore.instance.runTransaction((transaction) async {
    final snapshot = await transaction.get(userRef);

    if (!snapshot.exists) return;

    final data = snapshot.data() as Map<String, dynamic>;

    int currentPoints = data['points'] ?? 0;
    Timestamp? lastReward = data['lastDailyReward'];

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    bool canReward = true;

    if (lastReward != null) {
      final lastRewardDate = lastReward.toDate();
      final lastDay = DateTime(
        lastRewardDate.year,
        lastRewardDate.month,
        lastRewardDate.day,
      );

      if (lastDay == today) {
        canReward = false;
      }
    }

    if (canReward) {
      transaction.update(userRef, {
        'points': currentPoints + 5,
        'lastDailyReward': Timestamp.fromDate(today),
      });
      rewardGiven = true; // ✅ flag بدل ما تعرض الرسالة هنا
    }
  });

  return rewardGiven;
}
