import 'package:i_smile_kids_app/core/api/api_services/api_services.dart';
import 'package:i_smile_kids_app/core/api/models/doctors_list_model/doctor.dart';

abstract class GetDoctorListDataSource {
  Future<List<Doctor>> getDoctorList();
}

class GetDoctorListDataSourceImpl extends GetDoctorListDataSource {
  final ApiServices api;

  GetDoctorListDataSourceImpl(this.api);

  @override
  Future<List<Doctor>> getDoctorList() async {
    try {
      final res = await api.get(endPoint: '/doctors');

      // هنا نتأكد إن ال response List
      if (res is List) {
        return res.map((json) => Doctor.fromJson(json)).toList();
      } else {
        throw Exception("Unexpected response format: $res");
      }
    } catch (e) {
      throw Exception("Failed to fetch doctors: $e");
    }
  }
}
