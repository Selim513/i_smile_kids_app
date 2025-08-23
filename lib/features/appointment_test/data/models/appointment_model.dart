class AppointmentModel {
  final String id;
  final String doctorId;
  final String patientName;
  final int patientAge;
  final String problem;
  final DateTime appointmentDate;
  final String timeSlot;
  final AppointmentStatus status;
  final DateTime createdAt;

  AppointmentModel({
    required this.id,
    required this.doctorId,
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
      patientName: json['patientName'] ?? '',
      patientAge: json['patientAge'] ?? 0,
      problem: json['problem'] ?? '',
      appointmentDate: DateTime.parse(json['appointmentDate']),
      timeSlot: json['timeSlot'] ?? '',
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AppointmentStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'patientName': patientName,
      'patientAge': patientAge,
      'problem': problem,
      'appointmentDate': appointmentDate.toIso8601String(),
      'timeSlot': timeSlot,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

enum AppointmentStatus { pending, confirmed, cancelled, completed }
