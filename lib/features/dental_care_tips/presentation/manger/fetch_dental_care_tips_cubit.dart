import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/data/repo/dental_care_tips_repo_impl.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/presentation/manger/fetch_dental_care_tips_state.dart';

class FetchDentalCareTipsCubit extends Cubit<FetchDentalCareTipsState> {
  final DentalCareTipsRepoImpl repo;
  FetchDentalCareTipsCubit(this.repo) : super(FetchDentalCareTipsInitial());

  void fetchDentalCareTipsData() async {
    try {
      emit(FetchDentalCareTipsLoading());
      final data = await repo.fetchDentalCareTips();
      emit(FetchDentalCareTipsSuccess(tips: data));
    } catch (e) {
      emit(
        FetchDentalCareTipsFailure(
          errMessage: 'Please check your internet and try again later !',
        ),
      );
    }
  }
}
