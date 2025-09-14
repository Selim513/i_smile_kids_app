import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardAppointment {
  final String id;
  final String patientName;
  final String patientId;
  final String date;
  final String time;
  final String status; // 'confirmed', 'completed', 'cancelled', 'missed'
  final String doctorName;
  final String? notes;
  final DateTime createdAt;
  final PatientDetails patientDetails;

  DashboardAppointment({
    required this.id,
    required this.patientName,
    required this.patientId,
    required this.date,
    required this.time,
    required this.status,
    required this.doctorName,
    this.notes,
    required this.createdAt,
    required this.patientDetails,
  });

  factory DashboardAppointment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DashboardAppointment(
      id: doc.id,
      patientName: data['patientDetails']['name'] ?? '',
      patientId: data['patientDetails']['patientId'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      status: data['status'] ?? 'confirmed',
      doctorName: data['doctorName'] ?? '',
      notes: data['notes'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      patientDetails: PatientDetails.fromMap(data['patientDetails'] ?? {}),
    );
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'status': status,
      'notes': notes,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}

class PatientDetails {
  final String name;
  final String patientId;
  final String age;
  // final String profileImage;
  final String? nationality;
  final String? emirateOfResidency;

  PatientDetails({
    required this.name,
    //  required   this.profileImage,
    required this.patientId,
    required this.age,
    this.nationality,
    this.emirateOfResidency,
  });

  factory PatientDetails.fromMap(Map<String, dynamic> data) {
    return PatientDetails(
      name: data['name'] ?? '',
      // profileImage: data[],
      patientId: data['patientId'] ?? '',
      age: data['age'] ?? '',
      nationality: data['nationality'],
      emirateOfResidency: data['emirateOfResidency'],
    );
  }
}

class PatientStatistics {
  final int totalPatients;
  final int todayAppointments;
  final int completedAppointments;
  final int cancelledAppointments;
  final int missedAppointments;
  final Map<String, int> ageGroups;

  PatientStatistics({
    required this.totalPatients,
    required this.todayAppointments,
    required this.completedAppointments,
    required this.cancelledAppointments,
    required this.missedAppointments,
    required this.ageGroups,
  });
}
