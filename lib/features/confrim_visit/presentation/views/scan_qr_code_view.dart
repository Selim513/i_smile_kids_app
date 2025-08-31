import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // دالة إضافة النقاط المحدثة
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

  // دالة للتحقق من صحة QR Code وإضافة النقاط
  Future<void> handleQRScan(String qrData) async {
    if (isProcessing) return; // منع المسح المتكرر

    setState(() {
      isProcessing = true;
    });

    try {
      // التحقق من أن QR Code صحيح
      // ممكن تخليه "DOCTOR_VISIT" أو أي كود ثابت
      if (qrData == "DOCTOR_VISIT_50_POINTS") {
        // التحقق من أن المستخدم لم يحصل على نقاط اليوم
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

            // لو زار النهارده خلاص، ميقدرش ياخد نقاط تاني
            if (lastDay == today) {
              canGetPoints = false;
            }
          }

          if (canGetPoints) {
            // إضافة النقاط وحفظ تاريخ آخر زيارة
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🎉 تم إضافة 50 نقطة لزيارة الطبيب!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('لقد حصلت على نقاط الزيارة اليوم بالفعل!'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          }
        }
      } else {
        // QR Code غير صحيح
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('QR Code غير صحيح!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      setState(() {
        isProcessing = false;
      });
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
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  final qrData = barcode.rawValue ?? "";
                  setState(() {
                    result = qrData;
                  });

                  // معالجة QR Code
                  if (qrData.isNotEmpty && !isProcessing) {
                    handleQRScan(qrData);
                  }
                }
                controller.stop();
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
                    ? Text(
                        'Result: $result',
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      )
                    : const Text(
                        'لتأكيد زيارتك، امسح QR Code الخاص بالطبيب',
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
