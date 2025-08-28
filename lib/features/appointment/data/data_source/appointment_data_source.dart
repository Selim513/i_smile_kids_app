
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_smile_kids_app/features/appointment/data/models/appointment_model.dart';
import 'package:i_smile_kids_app/features/appointment/data/models/time_slot_model.dart';

class AppointmentRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<TimeSlotModel>> getAvailableTimeSlots(
    String doctorId,
    DateTime date,
  ) async {
    try {
      // البحث عن المواعيد المتاحة للدكتور في التاريخ المحدد
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      final QuerySnapshot querySnapshot = await _firestore
          .collection('time_slots')
          .where('doctorId', isEqualTo: doctorId)
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
          .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
          .where('isAvailable', isEqualTo: true)
          .orderBy('date', descending: false)
          .get();

      return querySnapshot.docs
          .map(
            (doc) => TimeSlotModel.fromJson({
              'id': doc.id,
              ...doc.data() as Map<String, dynamic>,
            }),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get available time slots: $e');
    }
  }

  Future<bool> bookAppointment(AppointmentModel appointment) async {
    try {
      return await _firestore.runTransaction((transaction) async {
        // البحث عن الموعد المتاح بناءً على deterministic ID المستخدم في initialization
        final dayOnly = DateTime(
          appointment.appointmentDate.year,
          appointment.appointmentDate.month,
          appointment.appointmentDate.day,
        );

        final timeParts = appointment.timeSlot.split(':');
        final hour = int.parse(timeParts[0]);
        final minute = int.parse(timeParts[1]);

        final docId =
            '${appointment.doctorId}_${dayOnly.year}${dayOnly.month.toString().padLeft(2, '0')}${dayOnly.day.toString().padLeft(2, '0')}_${hour.toString().padLeft(2, '0')}${minute.toString().padLeft(2, '0')}';

        final timeSlotRef = _firestore.collection('time_slots').doc(docId);
        final timeSlotDoc = await transaction.get(timeSlotRef);

        if (!timeSlotDoc.exists || timeSlotDoc.data()?['isAvailable'] != true) {
          throw Exception('Time slot is no longer available');
        }

        // إنشاء الحجز
        final appointmentRef = _firestore.collection('appointments').doc();
        final appointmentData = appointment.toJson();
        appointmentData['id'] = appointmentRef.id;

        // ✅ أضفنا الـ timestamps هنا بدل ما يكونوا في الموديل
        appointmentData['createdAt'] = FieldValue.serverTimestamp();
        appointmentData['updatedAt'] = FieldValue.serverTimestamp();

        transaction.set(appointmentRef, appointmentData);

        // تحديث حالة الموعد إلى غير متاح
        transaction.update(timeSlotRef, {'isAvailable': false});

        return true;
      });
    } catch (e) {
      

      return false;
    }
  }

  Future<bool> updateTimeSlotAvailability(
    String timeSlotId,
    bool isAvailable,
  ) async {
    try {
      await _firestore.collection('time_slots').doc(timeSlotId).update({
        'isAvailable': isAvailable,
      });
      return true;
    } catch (e) {
     
      return false;
    }
  }

  Future<List<AppointmentModel>> getDoctorAppointments(
    String doctorId,
    DateTime date,
  ) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('appointments')
          .where('doctorId', isEqualTo: doctorId)
          .where('appointmentDate', isEqualTo: Timestamp.fromDate(date))
          .get();

      return querySnapshot.docs
          .map(
            (doc) =>
                AppointmentModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get doctor appointments: $e');
    }
  }

  // جلب مواعيد المستخدم الحالي
  Future<List<AppointmentModel>> getUserAppointments() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('User not authenticated');

      final QuerySnapshot querySnapshot = await _firestore
          .collection('appointments')
          .where('patientUid', isEqualTo: userId)
          .orderBy('appointmentDate', descending: false)
          .get();

      return querySnapshot.docs
          .map(
            (doc) =>
                AppointmentModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get user appointments: $e');
    }
  }

  // إلغاء موعد المستخدم
  Future<bool> cancelAppointment(String appointmentId) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('User not authenticated');

      return await _firestore.runTransaction((transaction) async {
        // جلب الموعد للتأكد من الملكية
        final appointmentRef = _firestore
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

        final timeSlotRef = _firestore
            .collection('time_slots')
            .doc(timeSlotDocId);
        transaction.update(timeSlotRef, {'isAvailable': true});

        return true;
      });
    } catch (e) {
      return false;
    }
  }

  // إضافة مواعيد افتراضية للدكتور (يتم تشغيلها مرة واحدة)
  Future<void> initializeDoctorTimeSlots(String doctorId) async {
    final timeSlots = [
      '09:00',
      '09:30',
      '10:00',
      '10:30',
      '11:00',
      '11:30',
      '12:00',
      '12:30',
      '14:00',
      '14:30',
      '15:00',
      '15:30',
      '16:00',
      '16:30',
      '17:00',
    ];

    final batch = _firestore.batch();
    int opCount = 0;
    const int maxBatch = 450;

    for (int i = 0; i < 30; i++) {
      final date = DateTime.now().add(Duration(days: i));
      final dayOnly = DateTime(date.year, date.month, date.day);

      for (final time24 in timeSlots) {
        final parts = time24.split(':');
        final hour = int.tryParse(parts[0]) ?? 0;
        final minute = int.tryParse(parts[1]) ?? 0;

        // slot DateTime كامل (اليوم + الوقت)
        final slotDateTime = DateTime(
          dayOnly.year,
          dayOnly.month,
          dayOnly.day,
          hour,
          minute,
        );

        // deterministic id: doctorId_YYYYMMDD_HHMM
        final docId =
            '${doctorId}_${dayOnly.year}${dayOnly.month.toString().padLeft(2, '0')}${dayOnly.day.toString().padLeft(2, '0')}_${hour.toString().padLeft(2, '0')}${minute.toString().padLeft(2, '0')}';

        final docRef = _firestore.collection('time_slots').doc(docId);

        final data = {
          'doctorId': doctorId,
          'date': Timestamp.fromDate(slotDateTime), // مهم للتصفية والفلترة
          'time': time24, // مخزن بصيغة 24h علشان السورت يبقى سهل
          'displayTime': toAmPm(time24),
          'isAvailable': true,
          'createdAt': FieldValue.serverTimestamp(),
        };

        batch.set(docRef, data);
        opCount++;

        if (opCount >= maxBatch) {
          await batch.commit();
          opCount = 0;
          // إنشاء batch جديد
        }
      }
    }

    if (opCount > 0) {
      await batch.commit();
    }
  }

  // helper
  String toAmPm(String time24) {
    final parts = time24.split(':');
    int h = int.parse(parts[0]);
    final m = parts[1];
    final period = h >= 12 ? 'PM' : 'AM';
    final h12 = (h % 12 == 0) ? 12 : h % 12;
    return '${h12.toString().padLeft(2, '0')}:$m $period';
  }
}
