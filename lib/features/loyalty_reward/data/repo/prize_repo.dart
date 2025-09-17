import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:i_smile_kids_app/features/loyalty_reward/data/model/prize_model.dart';

class LoyaltyRewardRepo {
  Future<List<PrizeModel>> fetchPrizeData() async {
    try {
      var res = await rootBundle.loadString(
        'assets/json/loyalty_points_prizes_all_icons_v3.json',
      );
      final List data = jsonDecode(res);
      List<PrizeModel> people = data
          .map((e) => PrizeModel.fromJson(e))
          .toList();
      List<PrizeModel> dentalTipsList = [];
      for (var result in people) {
        dentalTipsList.add(result);
      }
      return dentalTipsList;
    } catch (e) {
      debugPrint('-----------------$e');
      throw Exception('Error :$e');
    }
  }
}
