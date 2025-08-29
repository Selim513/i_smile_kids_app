
class WorkShiftModel {
  final String? start;
  final String? end;

  WorkShiftModel({this.start, this.end});

  factory WorkShiftModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return WorkShiftModel();
    return WorkShiftModel(
      start: json['start'] as String?,
      end: json['end'] as String?,
    );
  }

  Map<String, dynamic>? toJson() {
    if (start == null || end == null) return null;
    return {'start': start, 'end': end};
  }
}

class DoctorsModel {
  final String docId;
  final String docName;
  final String aboutDoctor;
  final String docFullName;
  final String experienceYears;
  final String imageUrl;
  final String phone;
  final String specialization;
  final Map<String, WorkShiftModel> schedule;

  DoctorsModel({
    required this.docId,
    required this.docName,
    required this.aboutDoctor,
    required this.docFullName,
    required this.experienceYears,
    required this.imageUrl,
    required this.phone,
    required this.specialization,
    required this.schedule,
  });

  factory DoctorsModel.fromJson(Map<String, dynamic> json) {
    final scheduleJson = json['schedule'] as Map<String, dynamic>? ?? {};
    final schedule = scheduleJson.map((day, value) {
      return MapEntry(day, WorkShiftModel.fromJson(value));
    });

    return DoctorsModel(
      docId: json['doc_id'] ?? '',
      docName: json['doc_name'] ?? '',
      aboutDoctor: json['about_doctor'] ?? '',
      docFullName: json['doc_full_name'] ?? '',
      experienceYears: json['exp_years'] ?? '',
      imageUrl: json['image_url'] ?? '',
      phone: json['phone'] ?? '',
      specialization: json['specialization'] ?? '',
      schedule: schedule,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doc_id': docId,
      'doc_name': docName,
      'about_doctor': aboutDoctor,
      'doc_full_name': docFullName,
      'exp_years': experienceYears,
      'image_url': imageUrl,
      'phone': phone,
      'specialization': specialization,
      'schedule': schedule.map((day, shift) => MapEntry(day, shift.toJson())),
    };
  }
}
