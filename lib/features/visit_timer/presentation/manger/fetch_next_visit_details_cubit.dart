// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
// import 'package:i_smile_kids_app/features/visit_timer/data/models/patient_next_visit_model.dart';
// import 'package:i_smile_kids_app/features/visit_timer/presentation/manger/fetch_next_visit_details_state.dart';

// class FetchNextVisitDetailsCubit
//     extends Cubit<FetchNextVisitDetailsCubitState> {
//   FetchNextVisitDetailsCubit() : super(FetchNextVisitDetailsInital());

//   void fetchNextVisitDetails() async {
//     try {
//       emit(FetchNextVisitDetailsLoading());

//       // ✅ جلب المواعيد النشطة فقط (pending أو confirmed)
//       final snapshot = await FirebaseFirestore.instance
//           .collection('appointments')
//           .where('patientUid', isEqualTo: FirebaseHelper.user!.uid)
//           .where(
//             'status',
//             whereIn: ['pending', 'confirmed'],
//           ) // ✅ فلترة المواعيد النشطة فقط
//           .orderBy('appointmentDate')
//           .limit(1) // أقرب ميعاد نشط
//           .get();

//       if (snapshot.docs.isNotEmpty) {
//         final doc = snapshot.docs.first;
//         final data = doc.data();

//         // ✅ التأكد من أن الموعد مستقبلي
//         final appointmentDate = (data['appointmentDate'] as Timestamp).toDate();
//         final now = DateTime.now();

//         // إذا كان الموعد في المستقبل
//         if (appointmentDate.isAfter(now)) {
//           final visit = PatientNextVisit.fromFirestore(data, doc.id);
//           emit(FetchNextVisitDetailsSuccess(data: visit));
//         } else {
//           // إذا كان الموعد مضى عليه الوقت، ابحث عن موعد مستقبلي
//           await _fetchFutureAppointment();
//         }
//       } else {
//         emit(
//           FetchNextVisitDetailsFailure(
//             errMessage: "No upcoming appointments found",
//           ),
//         );
//       }
//     } catch (e) {
//       emit(FetchNextVisitDetailsFailure(errMessage: e.toString()));
//     }
//   }

//   // ✅ البحث عن مواعيد مستقبلية فقط
//   Future<void> _fetchFutureAppointment() async {
//     try {
//       final now = DateTime.now();

//       final snapshot = await FirebaseFirestore.instance
//           .collection('appointments')
//           .where('patientUid', isEqualTo: FirebaseHelper.user!.uid)
//           .where('status', whereIn: ['pending', 'confirmed'])
//           .where(
//             'appointmentDate',
//             isGreaterThan: Timestamp.fromDate(now),
//           ) // ✅ مواعيد مستقبلية فقط
//           .orderBy('appointmentDate')
//           .limit(1)
//           .get();

//       if (snapshot.docs.isNotEmpty) {
//         final doc = snapshot.docs.first;
//         final data = doc.data();
//         final visit = PatientNextVisit.fromFirestore(data, doc.id);
//         emit(FetchNextVisitDetailsSuccess(data: visit));
//       } else {
//         emit(
//           FetchNextVisitDetailsFailure(
//             errMessage: "No upcoming appointments found",
//           ),
//         );
//       }
//     } catch (e) {
//       emit(FetchNextVisitDetailsFailure(errMessage: e.toString()));
//     }
//   }

//   // ✅ إضافة method لتحديث البيانات بعد حجز موعد جديد
//   void refreshNextVisitDetails() {
//     fetchNextVisitDetails();
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/features/visit_timer/data/models/patient_next_visit_model.dart';
import 'package:i_smile_kids_app/features/visit_timer/presentation/manger/fetch_next_visit_details_state.dart';

class FetchNextVisitDetailsCubit
    extends Cubit<FetchNextVisitDetailsCubitState> {
  FetchNextVisitDetailsCubit() : super(FetchNextVisitDetailsInital());

  void fetchNextVisitDetails() async {
    try {
      emit(FetchNextVisitDetailsLoading());

      // ✅ جلب المواعيد النشطة من اليوم فما فوق
      final today = DateTime.now();
      final startOfToday = DateTime(today.year, today.month, today.day);

      final snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('patientUid', isEqualTo: FirebaseHelper.user!.uid)
          .where('status', whereIn: ['pending', 'confirmed'])
          .where(
            'appointmentDate',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfToday),
          )
          .orderBy('appointmentDate')
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        final data = doc.data();
        final visit = PatientNextVisit.fromFirestore(data, doc.id);
        emit(FetchNextVisitDetailsSuccess(data: visit));
      } else {
        emit(
          FetchNextVisitDetailsFailure(
            errMessage: "No upcoming appointments found",
          ),
        );
      }
    } catch (e) {
      emit(FetchNextVisitDetailsFailure(errMessage: e.toString()));
    }
  }

  Future<bool> cancelAppointment(String appointmentId) async {
    try {
      var userId = FirebaseHelper.user!.uid;

      return await FirebaseFirestore.instance.runTransaction((
        transaction,
      ) async {
        // جلب الموعد للتأكد من الملكية
        final appointmentRef = FirebaseFirestore.instance
            .collection('appointments')
            .doc(appointmentId);
        final appointmentDoc = await transaction.get(appointmentRef);

        if (!appointmentDoc.exists) {
          throw Exception('Appointment not found');
        }

        final appointmentData = appointmentDoc.data() as Map<String, dynamic>;

        // التأكد من أن المستخدم يملك الموعد
        if (appointmentData['patientUid'] != userId) {
          throw Exception('Unauthorized to cancel this appointment');
        }

        // التأكد من أن الموعد قابل للإلغاء
        if (!['pending', 'confirmed'].contains(appointmentData['status'])) {
          throw Exception('Cannot cancel this appointment');
        }

        // إلغاء الموعد
        transaction.update(appointmentRef, {
          'status': 'cancelled',
          'updatedAt': FieldValue.serverTimestamp(),
        });

        // إرجاع الـ time slot للمتاح
        final doctorId = appointmentData['doctorId'];
        final appointmentDate =
            (appointmentData['appointmentDate'] as Timestamp).toDate();
        final timeSlot = appointmentData['timeSlot'];

        // إنشاء الـ time slot ID
        final dayOnly = DateTime(
          appointmentDate.year,
          appointmentDate.month,
          appointmentDate.day,
        );
        final timeParts = timeSlot.split(':');
        final hour = int.parse(timeParts[0]);
        final minute = int.parse(timeParts[1]);

        final timeSlotDocId =
            '${doctorId}_${dayOnly.year}${dayOnly.month.toString().padLeft(2, '0')}${dayOnly.day.toString().padLeft(2, '0')}_${hour.toString().padLeft(2, '0')}${minute.toString().padLeft(2, '0')}';

        final timeSlotRef = FirebaseFirestore.instance
            .collection('time_slots')
            .doc(timeSlotDocId);
        transaction.update(timeSlotRef, {'isAvailable': true});
        emit(AppointmentCanncle());
        return true;
      });
    } catch (e) {
      print('Error cancelling appointment: $e');
      return false;
    }
  }

  // ✅ إضافة method لتحديث البيانات بعد حجز موعد جديد
  void refreshNextVisitDetails() {
    fetchNextVisitDetails();
  }
}
