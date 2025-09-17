import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/loyalty_reward/data/repo/prize_repo.dart';
import 'package:i_smile_kids_app/features/loyalty_reward/presentation/manger/loyalty_reward_state.dart';

class FetchLoyaltyRewardCubit extends Cubit<FetchLoyaltyRewardState> {
  FetchLoyaltyRewardCubit(this.repo) : super(FetchLoyaltyRewardInitial());
  final LoyaltyRewardRepo repo;
  Future<void> fetchLoyaltyReward() async {
    try {
      emit(FetchLoyaltyRewardLoading());
      var prizeList = await repo.fetchPrizeData();
      emit(FetchLoyaltyRewardSuccess(prizeData: prizeList));
    } catch (e) {
      print(e);
      emit(FetchLoyaltyRewardFailure());
    }
  }
}
