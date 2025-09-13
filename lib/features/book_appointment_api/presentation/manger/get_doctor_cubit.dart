import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/book_appointment_api/data/data_source/remote_data_source/get_doctor_list_data_source.dart';
import 'package:i_smile_kids_app/features/book_appointment_api/presentation/manger/get_doctor_state.dart';

class GetDoctorCubit extends Cubit<GetDoctorState> {
  final GetDoctorListDataSourceImpl repo;
  GetDoctorCubit(this.repo) : super(GetDoctorInitial());
  Future<void> getDoctorList() async {
    try {
      emit(GetDoctorLoading());
      var doctors = await repo.getDoctorList();
      emit(GetDoctorSuccess(doctorList: doctors));
    } catch (e) {
      emit(GetDoctorFailure(errMessage: '---$e'));
    }
  }
}
