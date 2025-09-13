import 'package:i_smile_kids_app/core/api/models/doctors_list_model/doctor.dart';

abstract class AppointmentRepo {
  Future<List<Doctor>> getDoctorList();
}
