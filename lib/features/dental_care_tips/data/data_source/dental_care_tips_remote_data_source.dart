import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/data/models/dental_care_tips_model/dental_care_tips_model.dart';

abstract class DentalCareTipsRemoteDataSource {
  Future<List<DentalCareTipsModel>> fetchDentalCareTips();
}

class DentalCareTipsRemoteDataSourceImpl
    extends DentalCareTipsRemoteDataSource {
  @override
  Future<List<DentalCareTipsModel>> fetchDentalCareTips() async {
    try {
      var res = await rootBundle.loadString(
        'assets/json/dental_tips_tricks.json',
      );
      final List data = jsonDecode(res);
      List<DentalCareTipsModel> people = data
          .map((e) => DentalCareTipsModel.fromJson(e))
          .toList();
      List<DentalCareTipsModel> dentalTipsList = [];
      for (var result in people) {
        dentalTipsList.add(result);
      }
      return dentalTipsList;
    } catch (e) {
      throw Exception('Error :$e');
    }
  }
}
