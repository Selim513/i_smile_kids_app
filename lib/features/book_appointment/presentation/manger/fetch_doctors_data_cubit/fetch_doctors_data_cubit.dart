import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/repo/doctors_repo/docotrs_repo.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/manger/fetch_doctors_data_cubit/fetch_doctors_data_state.dart';

class FetchDoctorsDataCubit extends Cubit<FetchDoctorsDataState> {
  final DocotrsDataRepo repo;
  FetchDoctorsDataCubit(this.repo) : super(FetchDoctorsDataInitial());
  Future<void> fetchDoctorsData() async {
    emit(FetchDoctorsDataLoading());
    try {
      var data = await repo.fetchDoctorData();
      emit(FetchDoctorsDataSuccess(data: data));
    } catch (e) {
      emit(FetchDoctorsDataFailure(errMessage: e.toString()));
    }
  }
}
