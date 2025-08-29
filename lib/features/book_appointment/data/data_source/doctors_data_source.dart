import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/models/doctors_model.dart';

abstract class DoctorsRemoteDataSource {
  Future<List<DoctorsModel>> fetchDoctorData();
}

class DoctorsRemoteDataSourceImpl extends DoctorsRemoteDataSource {
  FirebaseFirestore firestore = FirebaseHelper.firebaseFirestore;
  @override
  Future<List<DoctorsModel>> fetchDoctorData() async {
    try {
      var data = await firestore.collection('doctors').get();
      List<DoctorsModel> doctorsList = [];
      for (var doc in data.docs) {
        doctorsList.add(DoctorsModel.fromJson(doc.data()));
      }
      return doctorsList;
    } on Exception catch (e) {
      throw Exception('Fetch Doctor Error:$e');
    }
  }
}
