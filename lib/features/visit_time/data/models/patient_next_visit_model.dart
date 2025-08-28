import 'package:cloud_firestore/cloud_firestore.dart';

class PatientNextVisit {
  final String id;
  final String doctorId;
  final String patientUid;
  final String patientName;
  final DateTime appointmentDate;
  final String timeSlot;
  final String status;

  PatientNextVisit({
    required this.id,
    required this.doctorId,
    required this.patientUid,
    required this.patientName,
    required this.appointmentDate,
    required this.timeSlot,
    required this.status,
  });

  factory PatientNextVisit.fromFirestore(
    Map<String, dynamic> data,
    String docId,
  ) {
    return PatientNextVisit(
      id: docId,
      doctorId: data['doctorId'] ?? '',
      patientUid: data['patientUid'] ?? '',
      patientName: data['patientName'] ?? '',
      appointmentDate: (data['appointmentDate'] as Timestamp).toDate(),
      timeSlot: data['timeSlot'] ?? '',
      status: data['status'] ?? 'pending',
    );
  }
}
