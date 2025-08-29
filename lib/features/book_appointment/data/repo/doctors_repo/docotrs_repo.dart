import 'package:i_smile_kids_app/features/book_appointment/data/models/doctors_model.dart';

abstract class DocotrsDataRepo {
  Future<List<DoctorsModel>> fetchDoctorData();
}
