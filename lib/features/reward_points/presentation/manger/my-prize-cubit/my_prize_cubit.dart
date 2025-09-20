import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/reward_points/data/repo/my_prize_model.dart';
import 'package:i_smile_kids_app/features/reward_points/presentation/manger/my-prize-cubit/my_prize_state.dart';

class MyPrizesCubit extends Cubit<MyPrizesState> {
  final MyPrizesRepository _repository;

  MyPrizesCubit(this._repository) : super(MyPrizesInitial());

  Future<void> loadMyPrizes() async {
    try {
      emit(MyPrizesLoading());
      final prizes = await _repository.fetchMyPrizes();
      emit(MyPrizesLoaded(prizes));
    } catch (e) {
      emit(MyPrizesError(e.toString()));
    }
  }
}