import 'package:i_smile_kids_app/features/dental_care_tips/data/models/dental_care_tips_model/dental_care_tips_model.dart';

abstract class DentalCareTipsRepo {
  Future<List<DentalCareTipsModel>> fetchDentalCareTips();
}
