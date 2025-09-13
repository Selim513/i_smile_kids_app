import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/dashboard/data/repo/dashboard_repo.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/manger/appointment_state.dart';

class AppointmentsListCubit extends Cubit<AppointmentsListState> {
  final DashboardRepository _repository;

  AppointmentsListCubit(this._repository) : super(AppointmentsListInitial());

  Future<void> loadAppointments({
    String? status,
    String? startDate,
    String? endDate,
  }) async {
    try {
      emit(AppointmentsListLoading());

      final appointments = await _repository.getAllAppointments(
        status: status,
        startDate: startDate,
        endDate: endDate,
      );

      emit(AppointmentsListLoaded(appointments));
    } catch (e) {
      emit(AppointmentsListError(e.toString()));
    }
  }

  Future<void> refreshAppointments() async {
    loadAppointments();
  }
}
