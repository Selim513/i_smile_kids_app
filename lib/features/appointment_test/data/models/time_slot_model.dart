import 'package:cloud_firestore/cloud_firestore.dart';

class TimeSlotModel {
  final String id;
  final String doctorId;
  final DateTime date;
  final String time;
  final String displayTime;
  final bool isAvailable;

  TimeSlotModel({
    required this.id,
    required this.doctorId,
    required this.date,
    required this.time,
    required this.displayTime,
    required this.isAvailable,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      id: json['id'] ?? '',
      displayTime: json['displayTime'],
      doctorId: json['doctorId'] ?? '',
      date: (json['date'] as Timestamp).toDate(),
      time: json['time'] ?? '',
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayTime':displayTime,
      'doctorId': doctorId,
      'date': date.toIso8601String(),
      'time': time,
      'isAvailable': isAvailable,
    };
  }
}
