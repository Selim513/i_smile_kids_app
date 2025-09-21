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
  final String problem;
  final String? profileImage;

  PatientDetails({
    required this.name,
    required this.profileImage,
    required this.patientId,
    required this.age,
    required this.problem,
  });

  // <<< تم تعديل هذه الدالة لتكون آمنة >>>
  factory PatientDetails.fromMap(Map<String, dynamic> data) {
    return PatientDetails(
      name: data['name'] ?? 'لا يوجد اسم',
      patientId: data['patientId'] ?? '', // الـ ID هيتم إضافته من الـ Repository
      age: data['age'] ?? 'غير محدد',
      profileImage: data['photoUrl'], // photoUrl يمكن أن يكون null
      // هنا بنضيف قيمة افتراضية لو حقل 'problem' مش موجود
      problem: data['problem'] ?? 'لا توجد مشكلة مسجلة',
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
class AllUsersModel {
  final String name;
  final String uid;
  final String? photoURL;
  final String age;

  AllUsersModel({
    required this.name,
    required this.uid,
    this.photoURL,
    required this.age,
  });

  factory AllUsersModel.fromMap(Map<String, dynamic> data) {
    return AllUsersModel(
      uid: data['uid'] ?? '',
      name: data['name'] ?? 'name',
      age: data['age'] ?? '0',
      photoURL: data['photoURL']??'',
    );
  }
}