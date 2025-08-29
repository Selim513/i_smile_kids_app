import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/models/appointment_test_model.dart';

abstract class BookAppointmentRemoteDataSource {
  Future<AppointmentDoctorAvailabilityModel> getDoctorAvailableTime({
    required String docId,
  });
  Future<String> bookAppointment({required BookAppointmentModel appointment});
  Future<List<BookAppointmentModel>> getPatientAppointments({
    required String patientId,
  });
  Future<void> cancelAppointment({
    required String appointmentId,
    required String doctorName,
    required String date,
    required String time,
  });
}

class AppointmentRemoteDataSourceTestImpl
    implements BookAppointmentRemoteDataSource {
  final FirebaseFirestore firestore;

  AppointmentRemoteDataSourceTestImpl({required this.firestore});

  @override
  Future<AppointmentDoctorAvailabilityModel> getDoctorAvailableTime({
    required String docId,
  }) async {
    try {
      final docSnapshot = await firestore
          .collection('doctor_appointment')
          .doc(docId)
          .get();

      if (!docSnapshot.exists) {
        throw Exception('Doctor not found');
      }

      return AppointmentDoctorAvailabilityModel.fromFirestore(docSnapshot);
    } catch (e) {
      throw Exception('Failed to get doctor availability: ${e.toString()}');
    }
  }

  @override
  Future<String> bookAppointment({
    required BookAppointmentModel appointment,
  }) async {
    try {
      // التحقق من أن الوقت لا يزال متاحاً
      final doctorDoc = await firestore
          .collection('doctor_appointment')
          .doc(appointment.doctorId)
          .get();

      if (doctorDoc.exists) {
        final data = doctorDoc.data();
        final List bookedSlots = data?['bookedSlots']?[appointment.date] ?? [];

        if (bookedSlots.contains(appointment.time)) {
          throw Exception('This time slot is no longer available');
        }
      }

      // بدء معاملة للتأكد من عدم حدوث تضارب
      final batch = firestore.batch();

      // إضافة الوقت المحجوز
      final doctorRef = firestore
          .collection('doctor_appointment')
          .doc(appointment.doctorId);
      batch.update(doctorRef, {
        'bookedSlots.${appointment.date}': FieldValue.arrayUnion([
          appointment.time,
        ]),
      });

      // حفظ بيانات الموعد
      final appointmentRef = firestore.collection('patient_appointments').doc();
      batch.set(appointmentRef, appointment.toFirestore());

      // تنفيذ المعاملة
      await batch.commit();

      return 'Appointment booked successfully for ${appointment.time} on ${appointment.date}';
    } catch (e) {
      throw Exception('Booking failed: ${e.toString()}');
    }
  }

  @override
  Future<List<BookAppointmentModel>> getPatientAppointments({
    required String patientId,
  }) async {
    try {
      final querySnapshot = await firestore
          .collection('patient_appointments')
          .where('patientDetails.patientId', isEqualTo: patientId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => BookAppointmentModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get patient appointments: ${e.toString()}');
    }
  }

  @override
  Future<void> cancelAppointment({
    required String appointmentId,
    required String doctorName,
    required String date,
    required String time,
  }) async {
    try {
      final batch = firestore.batch();

      // حذف الموعد
      final appointmentRef = firestore
          .collection('appointments')
          .doc(appointmentId);
      batch.delete(appointmentRef);

      // إزالة الوقت من الأوقات المحجوزة
      final doctorRef = firestore
          .collection('doctor_appointment')
          .doc(doctorName);
      batch.update(doctorRef, {
        'bookedSlots.$date': FieldValue.arrayRemove([time]),
      });

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to cancel appointment: ${e.toString()}');
    }
  }
}
