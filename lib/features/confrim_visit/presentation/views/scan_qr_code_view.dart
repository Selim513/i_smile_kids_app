// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:i_smile_kids_app/core/widgets/custom_snack_bar.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// class ScanQrCodeView extends StatefulWidget {
//   const ScanQrCodeView({super.key});

//   @override
//   State<ScanQrCodeView> createState() => _ScanQrCodeViewState();
// }

// class _ScanQrCodeViewState extends State<ScanQrCodeView>
//     with AutomaticKeepAliveClientMixin {
//   final MobileScannerController controller = MobileScannerController(
//     formats: const [BarcodeFormat.qrCode],
//     detectionSpeed: DetectionSpeed.noDuplicates,
//   );
//   String? result;
//   bool isProcessing = false;

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   // دالة إضافة النقاط المحدثة
//   Future<void> addPoints(int points) async {
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     if (uid == null) return;

//     final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

//     await FirebaseFirestore.instance.runTransaction((transaction) async {
//       final snapshot = await transaction.get(userRef);

//       if (!snapshot.exists) return;

//       int currentPoints = snapshot['points'] ?? 0;
//       transaction.update(userRef, {
//         'points': currentPoints + points,
//         'updatedAt': FieldValue.serverTimestamp(),
//       });
//     });
//   }

//   // دالة للتحقق من صحة QR Code وإضافة النقاط
//   Future<void> handleQRScan(String qrData) async {
//     if (isProcessing) return; // منع المسح المتكرر

//     setState(() {
//       isProcessing = true;
//     });

//     try {
//       // التحقق من أن QR Code صحيح
//       // ممكن تخليه "DOCTOR_VISIT" أو أي كود ثابت
//       if (qrData == "DOCTOR_VISIT_50_POINTS") {
//         // التحقق من أن المستخدم لم يحصل على نقاط اليوم
//         final uid = FirebaseAuth.instance.currentUser?.uid;
//         if (uid == null) return;

//         final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
//         final snapshot = await userRef.get();

//         if (snapshot.exists) {
//           final data = snapshot.data() as Map<String, dynamic>;
//           Timestamp? lastVisit = data['lastDoctorVisit'];

//           final now = DateTime.now();
//           final today = DateTime(now.year, now.month, now.day);

//           bool canGetPoints = true;

//           if (lastVisit != null) {
//             final lastVisitDate = lastVisit.toDate();
//             final lastDay = DateTime(
//               lastVisitDate.year,
//               lastVisitDate.month,
//               lastVisitDate.day,
//             );

//             // patinet can scan one time per day
//             if (lastDay == today) {
//               canGetPoints = false;
//             }
//           }

//           if (canGetPoints) {
//             // add points and save the date of the visit
//             await FirebaseFirestore.instance.runTransaction((
//               transaction,
//             ) async {
//               final snapshot = await transaction.get(userRef);
//               if (!snapshot.exists) return;

//               int currentPoints = snapshot['points'] ?? 0;
//               transaction.update(userRef, {
//                 'points': currentPoints + 50,
//                 'lastDoctorVisit': Timestamp.fromDate(today),
//                 'updatedAt': FieldValue.serverTimestamp(),
//               });
//             });

//             if (mounted) {
//               CustomSnackBar.successSnackBar(
//                 '🎉 50 points have been added for your doctor\'s visit!',
//                 context,
//               );
//             }
//           } else {
//             if (mounted) {
//               CustomSnackBar.warningSnackBar(
//                 'You\'ve already received your points for the day\'s visit.',
//                 context,
//               );
//             }
//           }
//         }
//       } else {
//         // invaild QR Code
//         if (mounted) {
//           CustomSnackBar.errorSnackBar('Invalid QR Code!', context);
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         CustomSnackBar.errorSnackBar('An error occurred: $e', context);
//       }
//     } finally {
//       setState(() {
//         isProcessing = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Scaffold(
//       appBar: AppBar(title: const Text('QR Code Scanner')),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 4,
//             child: MobileScanner(
//               key: GlobalKey(),
//               controller: controller,
//               onDetect: (capture) {
//                   if (isProcessing) return;
//                 final List<Barcode> barcodes = capture.barcodes;
//                 for (final barcode in barcodes) {
//                   final qrData = barcode.rawValue ?? "";
//                   setState(() {
//                     result = qrData;
//                   });

//                   // handling QR Code
//                   if (qrData.isNotEmpty && !isProcessing) {
//                     handleQRScan(qrData);
//                   }
//                 }
//                 controller.stop();
//               },
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Center(
//                 child: isProcessing
//                     ? const CircularProgressIndicator()
//                     : (result != null)
//                     ? SizedBox()
//                     : const Text(
//                         'Please scan the doctor\'s QR code to confirm your visit.',
//                         style: TextStyle(fontSize: 18),
//                         textAlign: TextAlign.center,
//                       ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => false;
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/widgets/custom_snack_bar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCodeView extends StatefulWidget {
  const ScanQrCodeView({super.key});

  @override
  State<ScanQrCodeView> createState() => _ScanQrCodeViewState();
}

class _ScanQrCodeViewState extends State<ScanQrCodeView>
    with AutomaticKeepAliveClientMixin {
  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  String? result;
  bool isProcessing = false;
  String? lastQr; // لتجنب تكرار نفس الكود

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // دالة إضافة النقاط
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

  // التحقق من QR Code
  Future<void> handleQRScan(String qrData) async {
    if (isProcessing) return;

    setState(() {
      isProcessing = true;
    });

    try {
      if (qrData == "DOCTOR_VISIT_50_POINTS") {
        final uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid == null) return;

        final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
        final snapshot = await userRef.get();

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
            await FirebaseFirestore.instance.runTransaction((
              transaction,
            ) async {
              final snapshot = await transaction.get(userRef);
              if (!snapshot.exists) return;

              int currentPoints = snapshot['points'] ?? 0;
              transaction.update(userRef, {
                'points': currentPoints + 50,
                'lastDoctorVisit': Timestamp.fromDate(today),
                'updatedAt': FieldValue.serverTimestamp(),
              });
            });

            if (mounted) {
              CustomSnackBar.successSnackBar(
                '🎉 50 points have been added for your doctor\'s visit!',
                context,
              );
            }
          } else {
            if (mounted) {
              CustomSnackBar.warningSnackBar(
                'You\'ve already received your points for the day\'s visit.',
                context,
              );
            }
          }
        }
      } else {
        if (mounted) {
          CustomSnackBar.errorSnackBar('Invalid QR Code!', context);
        }
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.errorSnackBar('An error occurred: $e', context);
      }
    } finally {
      setState(() {
        isProcessing = false;
      });
      controller.start(); // تشغيل الكاميرا من جديد بعد الانتهاء
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Scanner')),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: MobileScanner(
              key: GlobalKey(),
              controller: controller,
              onDetect: (capture) {
                if (isProcessing) return;

                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  final qrData = barcode.rawValue ?? "";

                  if (qrData.isEmpty) return;
                  if (qrData == lastQr) return; // تجاهل لو نفس الكود“
                  lastQr = qrData;

                  setState(() {
                    result = qrData;
                  });

                  controller.stop(); // وقف الكاميرا فوراً
                  handleQRScan(qrData);
                  Navigator.pop(context);
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: isProcessing
                    ? const CircularProgressIndicator()
                    : (result != null)
                    ? const SizedBox()
                    : const Text(
                        'Please scan the doctor\'s QR code to confirm your visit.',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
