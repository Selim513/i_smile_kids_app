import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/features/visit_time/data/models/patient_next_visit_model.dart';
import 'package:i_smile_kids_app/features/visit_time/presentation/manger/fetch_next_visit_details_state.dart';
import 'package:intl/intl.dart';

class FetchNextVisitDetailsCubit
    extends Cubit<FetchNextVisitDetailsCubitState> {
  FetchNextVisitDetailsCubit() : super(FetchNextVisitDetailsInital());

  void fetchNextVisitDetails() async {
    try {
      emit(FetchNextVisitDetailsLoading());

      final today = DateTime.now();
      final todayString = DateFormat('yyyy-MM-dd').format(today);

      final snapshot = await FirebaseFirestore.instance
          .collection('patient_appointments')
          .where(
            'patientDetails.name',
            isEqualTo: await _getCurrentUserName(),
          ) // ✅ البحث بالاسم
          .where('status', isEqualTo: 'confirmed')
          .orderBy('createdAt', descending: false)
          .get();

      if (snapshot.docs.isNotEmpty) {
        List<QueryDocumentSnapshot> futureAppointments = [];

        for (var doc in snapshot.docs) {
          final data = doc.data();
          final appointmentDate = data['date'] as String;
          final appointmentTime = data['time'] as String;

          DateTime appointmentDateTime = _parseAppointmentDateTime(
            appointmentDate,
            appointmentTime,
          );

          if (appointmentDateTime.isAfter(today) ||
              (appointmentDate == todayString &&
                  appointmentDateTime.isAfter(today))) {
            futureAppointments.add(doc);
          }
        }

        if (futureAppointments.isNotEmpty) {
          // أقرب موعد مستقبلي
          futureAppointments.sort((a, b) {
            final dataA = a.data() as Map<String, dynamic>;
            final dataB = b.data() as Map<String, dynamic>;

            final dateTimeA = _parseAppointmentDateTime(
              dataA['date'],
              dataA['time'],
            );
            final dateTimeB = _parseAppointmentDateTime(
              dataB['date'],
              dataB['time'],
            );

            return dateTimeA.compareTo(dateTimeB);
          });

          final nextAppointment = futureAppointments.first;
          final data = nextAppointment.data() as Map<String, dynamic>;
          final visit = PatientNextVisit.fromNewStructure(
            data,
            nextAppointment.id,
          );
          emit(FetchNextVisitDetailsSuccess(data: visit));
        } else {
          emit(
            FetchNextVisitDetailsFailure(
              errMessage: "No upcoming appointments found",
            ),
          );
        }
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

  DateTime _parseAppointmentDateTime(String date, String time) {
    try {
      final dateParts = date.split('-');
      final year = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final day = int.parse(dateParts[2]);

      final parsedTime = DateFormat('h:mm a').parse(time);

      return DateTime(year, month, day, parsedTime.hour, parsedTime.minute);
    } catch (e) {
      return DateTime(1900);
    }
  }

  Future<String> _getCurrentUserName() async {
    try {
      final uid = FirebaseHelper.user!.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        return userData['name'] ?? '';
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  Future<bool> cancelAppointment(String appointmentId) async {
    try {
      final firestore = FirebaseFirestore.instance;

      await firestore.runTransaction((transaction) async {
        final appointmentRef = firestore
            .collection('patient_appointments')
            .doc(appointmentId);

        final appointmentDoc = await transaction.get(appointmentRef);
        if (!appointmentDoc.exists) {
          throw Exception('Appointment not found');
        }

        final appointmentData = appointmentDoc.data() as Map<String, dynamic>;

        // لاحظ: خلينا نحاول نستخدم doctorId لو موجود، وإلا نستخدم doctorName كـ fallback
        final doctorIdOrName =
            appointmentData['doctorId'] ?? appointmentData['doctorName'];
        final date = appointmentData['date'];
        final time = appointmentData['time'];

        final doctorRef = firestore
            .collection('doctor_appointment')
            .doc(doctorIdOrName);

        final doctorDoc = await transaction.get(doctorRef);

        if (doctorDoc.exists) {
          transaction.update(doctorRef, {
            'bookedSlots.$date': FieldValue.arrayRemove([time]),
          });
        }

        transaction.delete(appointmentRef);
      });

      emit(AppointmentCanncle());
      return true;
    } catch (e) {
      emit(FetchNextVisitDetailsFailure(errMessage: e.toString()));
      return false;
    }
  }

  void refreshNextVisitDetails() {
    fetchNextVisitDetails();
  }
}
