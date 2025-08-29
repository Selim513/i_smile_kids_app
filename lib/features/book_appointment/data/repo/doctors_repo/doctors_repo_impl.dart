import 'package:i_smile_kids_app/features/book_appointment/data/data_source/doctors_data_source.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/models/doctors_model.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/repo/doctors_repo/docotrs_repo.dart';

class DoctorsDataRepoImpl extends DocotrsDataRepo {
  final DoctorsRemoteDataSource data;

  DoctorsDataRepoImpl(this.data);
  @override
  Future<List<DoctorsModel>> fetchDoctorData() async {
    return await data.fetchDoctorData();
  }
}
