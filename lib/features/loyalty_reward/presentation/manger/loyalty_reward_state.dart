import 'package:i_smile_kids_app/features/loyalty_reward/data/model/prize_model.dart';

abstract class FetchLoyaltyRewardState {}

class FetchLoyaltyRewardInitial extends FetchLoyaltyRewardState {}

class FetchLoyaltyRewardSuccess extends FetchLoyaltyRewardState {
  final List<PrizeModel> prizeData;

  FetchLoyaltyRewardSuccess({required this.prizeData});
}

class FetchLoyaltyRewardFailure extends FetchLoyaltyRewardState {}

class FetchLoyaltyRewardLoading extends FetchLoyaltyRewardState {}
