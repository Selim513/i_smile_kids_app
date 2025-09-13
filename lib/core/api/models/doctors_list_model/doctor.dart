class Doctor {
  int? doctorId;
  String? doctorFireBaseId;
  String? fullName;
  String? speciality;
  dynamic email;

  Doctor({
    this.doctorId,
    this.doctorFireBaseId,
    this.fullName,
    this.speciality,
    this.email,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    doctorId: json['doctorId'] as int?,
    doctorFireBaseId: json['doctorFireBaseId'] as String?,
    fullName: json['fullName'] as String?,
    speciality: json['speciality'] as String?,
    email: json['email'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'doctorId': doctorId,
    'doctorFireBaseId': doctorFireBaseId,
    'fullName': fullName,
    'speciality': speciality,
    'email': email,
  };
}
