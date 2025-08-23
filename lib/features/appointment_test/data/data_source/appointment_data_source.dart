import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_smile_kids_app/features/appointment_test/data/models/appointment_model.dart';
import 'package:i_smile_kids_app/features/appointment_test/data/models/time_slot_model.dart';

class AppointmentRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      // بدء transaction لضمان الحجز الآمن
      return await _firestore.runTransaction((transaction) async {
        // التحقق من توفر الموعد أولاً
        final timeSlotQuery = await _firestore
            .collection('time_slots')
            .where('doctorId', isEqualTo: appointment.doctorId)
            .where(
              'date',
              isEqualTo: Timestamp.fromDate(appointment.appointmentDate),
            )
            .where('time', isEqualTo: appointment.timeSlot)
            .where('isAvailable', isEqualTo: true)
            .get();

        if (timeSlotQuery.docs.isEmpty) {
          throw Exception('Time slot is no longer available');
        }

        final timeSlotDoc = timeSlotQuery.docs.first;

        // إنشاء الحجز
        final appointmentRef = _firestore.collection('appointments').doc();
        transaction.set(
          appointmentRef,
          appointment.toJson()..['id'] = appointmentRef.id,
        );

        // تحديث حالة الموعد إلى غير متاح
        transaction.update(timeSlotDoc.reference, {'isAvailable': false});

        return true;
      });
    } catch (e) {
      print('Error booking appointment: $e');
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
      print('Error updating time slot availability: $e');
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

        // slot DateTime کامل (اليوم + الوقت)
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
          // reset batch
          opCount = 0;
          // new batch
          // ignore: invalid_use_of_protected_member
          // (بس في cloud_firestore الحالي: بعمل batch = _firestore.batch();)
          // علشان Dart analyzer: نعمل الطريقة السليمة:
          // create new batch:
          // batch = _firestore.batch(); // لو batch var غير final
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
