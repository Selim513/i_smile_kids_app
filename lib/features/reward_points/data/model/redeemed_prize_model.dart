import 'package:cloud_firestore/cloud_firestore.dart';

class RedeemedPrizeModel {
  final String id; // Document ID
  final String prizeName;
  final String prizeDescription;
  final String prizeIcon;
  final int pointsSpent;
  final Timestamp redeemedAt;

  RedeemedPrizeModel({
    required this.id,
    required this.prizeName,
    required this.prizeDescription,
    required this.prizeIcon,
    required this.pointsSpent,
    required this.redeemedAt,
  });

  factory RedeemedPrizeModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RedeemedPrizeModel(
      id: doc.id,
      prizeName: data['prizeName'] ?? 'No Name',
      prizeDescription: data['prizeDescription'] ?? 'No Description',
      prizeIcon: data['prizeIcon'] ?? '🎁',
      pointsSpent: data['pointsSpent'] ?? 0,
      redeemedAt: data['redeemedAt'] ?? Timestamp.now(),
    );
  }
}