import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PatientNextVisit {
  final String id;
  final String doctorName;
  final String patientName;
  final DateTime appointmentDate; // date + time
  final String timeSlot;
  final String status;

  PatientNextVisit({
    required this.id,
    required this.doctorName,
    required this.patientName,
    required this.appointmentDate,
    required this.timeSlot,
    required this.status,
  });

  // Factory للـ structure القديم
  factory PatientNextVisit.fromFirestore(
    Map<String, dynamic> data,
    String docId,
  ) {
    return PatientNextVisit(
      id: docId,
      doctorName: data['doctorId'] ?? '',
      patientName: data['patientName'] ?? '',
      appointmentDate: (data['appointmentDate'] as Timestamp).toDate(),
      timeSlot: data['timeSlot'] ?? '',
      status: data['status'] ?? 'pending',
    );
  }

  // ✅ Factory جديد للـ structure الجديد
  factory PatientNextVisit.fromNewStructure(
    Map<String, dynamic> data,
    String docId,
  ) {
    // دمج التاريخ والوقت
    final dateString = data['date'] as String;
    final timeString = data['time'] as String;

    DateTime appointmentDateTime;
    try {
      final dateParts = dateString.split('-');
      final year = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final day = int.parse(dateParts[2]);

      final parsedTime = DateFormat('h:mm a').parse(timeString);
      appointmentDateTime = DateTime(
        year,
        month,
        day,
        parsedTime.hour,
        parsedTime.minute,
      );
    } catch (e) {
      appointmentDateTime = DateTime.now();
    }

    return PatientNextVisit(
      id: docId,
      doctorName: data['doctorName'] ?? '',
      patientName: data['patientDetails']?['name'] ?? '',
      appointmentDate: appointmentDateTime,
      timeSlot: timeString,
      status: data['status'] ?? 'confirmed',
    );
  }
}
