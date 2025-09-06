// Data/Models/appointment_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class BookAppointmentModel {
  final String? id;
  final String doctorId;
  final String doctorName;
  final String date;
  final String time;
  final AppointmentPatientDetailsModel patientDetails;
  final String status;
  final DateTime createdAt;

  BookAppointmentModel({
    this.id,
    required this.doctorId,
    required this.doctorName,
    required this.date,
    required this.time,
    required this.patientDetails,
    required this.status,
    required this.createdAt,
  });

  factory BookAppointmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BookAppointmentModel(
      id: doc.id,
      doctorId: data['doctorId'] ?? '',
      doctorName: data['doctorName'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      patientDetails: AppointmentPatientDetailsModel.fromMap(
        data['patientDetails'] ?? {},
      ),
      status: data['status'] ?? 'pending',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'doctorId': doctorId,
      'doctorName': doctorName,
      'date': date,
      'time': time,
      'patientDetails': patientDetails.toMap(),
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

class AppointmentPatientDetailsModel {
  final String name;
  final String age;
  final String problem;

  AppointmentPatientDetailsModel({
    required this.name,
    required this.age,
    required this.problem,
  });

  factory AppointmentPatientDetailsModel.fromMap(Map<String, dynamic> map) {
    return AppointmentPatientDetailsModel(
      name: map['name'] ?? '',
      age: map['age'] ?? '',
      problem: map['problem'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'age': age, 'problem': problem};
  }
}

class AppointmentDoctorAvailabilityModel {
  final String doctorName;
  final Map<String, DaySchedule> schedule; // Map اليوم -> التوقيتات
  final Map<String, List<String>> bookedSlots;

  AppointmentDoctorAvailabilityModel({
    required this.doctorName,
    required this.schedule,
    required this.bookedSlots,
  });

  // getter للحصول على أيام الشغل
  List<String> get workingDays => schedule.keys.toList();

  factory AppointmentDoctorAvailabilityModel.fromFirestore(
    DocumentSnapshot doc,
  ) {
    final data = doc.data() as Map<String, dynamic>;

    // تحويل الـ schedule من الـ database
    Map<String, DaySchedule> schedule = {};
    if (data['schedule'] != null) {
      final rawSchedule = data['schedule'] as Map<String, dynamic>;
      rawSchedule.forEach((day, times) {
        if (times is Map<String, dynamic>) {
          schedule[day] = DaySchedule(
            startTime: times['startTime'] ?? '',
            endTime: times['endTime'] ?? '',
          );
        }
      });
    }

    // تحويل bookedSlots
    Map<String, List<String>> bookedSlots = {};
    if (data['bookedSlots'] != null) {
      final rawBookedSlots = data['bookedSlots'] as Map<String, dynamic>;
      rawBookedSlots.forEach((key, value) {
        if (value is List) {
          bookedSlots[key] = List<String>.from(value);
        } else {
          bookedSlots[key] = [];
        }
      });
    }

    return AppointmentDoctorAvailabilityModel(
      doctorName: doc.id,
      schedule: schedule,
      bookedSlots: bookedSlots,
    );
  }
}

class DaySchedule {
  final String startTime;
  final String endTime;

  DaySchedule({required this.startTime, required this.endTime});
}
