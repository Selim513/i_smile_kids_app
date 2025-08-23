
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  final String doctorId;
  final String patientUid; // إضافة uid المستخدم للـ security
  final String patientName;
  final String patientAge;
  final String problem;
  final DateTime appointmentDate;
  final String timeSlot;
  final AppointmentStatus status;
  final DateTime createdAt;

  AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.patientUid,
    required this.patientName,
    required this.patientAge,
    required this.problem,
    required this.appointmentDate,
    required this.timeSlot,
    required this.status,
    required this.createdAt,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] ?? '',
      doctorId: json['doctorId'] ?? '',
      patientUid: json['patientUid'] ?? '',
      patientName: json['patientName'] ?? '',
      patientAge: json['patientAge'] ?? 0,
      problem: json['problem'] ?? '',
      appointmentDate: _parseDateTime(json['appointmentDate']),
      timeSlot: json['timeSlot'] ?? '',
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AppointmentStatus.pending,
      ),
      createdAt: _parseDateTime(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'id': id,
    'doctorId': doctorId,
    'patientUid': patientUid,
    'patientName': patientName,
    'patientAge': patientAge,
    'problem': problem,
    'appointmentDate': Timestamp.fromDate(appointmentDate),
    'timeSlot': timeSlot,
    'status': status.name,
    // سيب السيرفر يزودهم بعدين
  };
}

  static DateTime _parseDateTime(dynamic dateValue) {
    if (dateValue == null) return DateTime.now();
    
    if (dateValue is Timestamp) {
      return dateValue.toDate();
    } else if (dateValue is String) {
      return DateTime.parse(dateValue);
    } else if (dateValue is DateTime) {
      return dateValue;
    }
    
    return DateTime.now();
  }

  AppointmentModel copyWith({
    String? id,
    String? doctorId,
    String? patientUid,
    String? patientName,
    String? patientAge,
    String? problem,
    DateTime? appointmentDate,
    String? timeSlot,
    AppointmentStatus? status,
    DateTime? createdAt,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      patientUid: patientUid ?? this.patientUid,
      patientName: patientName ?? this.patientName,
      patientAge: patientAge ?? this.patientAge,
      problem: problem ?? this.problem,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      timeSlot: timeSlot ?? this.timeSlot,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

enum AppointmentStatus { pending, confirmed, cancelled, completed }