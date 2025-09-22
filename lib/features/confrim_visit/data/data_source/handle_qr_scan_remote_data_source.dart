import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';

abstract class HandleQrScanRemoteDataSource {
  Future<void> handleQrScan({required String qrData});
}

class HandleQrScanRemoteDataSourceImpl extends HandleQrScanRemoteDataSource {
  FirebaseFirestore firestore = FirebaseHelper.firebaseFirestore;

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<void> handleQrScan({required String qrData}) async {
    // check if the qr is valid
    try {
      if (qrData != "DOCTOR_VISIT_50_POINTS") {
        throw ('Invalid QR Code!');
      }
      // chekc if user exist
      final userUid = auth.currentUser?.uid;
      if (userUid == null) {
        throw ('User is not authenticated.');
      }
      final userRef = firestore.collection('users').doc(userUid);
      final snapshot = await userRef.get();
      //----
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        Timestamp? lastVisit = data['lastDoctorVisit'];

        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        bool canGetPoints = true;

        if (lastVisit != null) {
          final lastVisitDate = lastVisit.toDate();
          final lastDay = DateTime(
            lastVisitDate.year,
            lastVisitDate.month,
            lastVisitDate.day,
          );
          if (lastDay == today) {
            canGetPoints = false;
          }
        }

        if (canGetPoints) {
          await FirebaseFirestore.instance.runTransaction((transaction) async {
            final snapshot = await transaction.get(userRef);
            if (!snapshot.exists) return;

            int currentPoints = snapshot['points'] ?? 0;
            transaction.update(userRef, {
              'points': currentPoints + 50,
              'lastDoctorVisit': Timestamp.fromDate(today),
              'updatedAt': FieldValue.serverTimestamp(),
            });
          });
        }
      }
    } on Exception catch (e) {
      print('---------Error==${e.toString()}');
      throw Exception('There is something went wrong please try again !.');
    }
  }
}
