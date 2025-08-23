import 'package:i_smile_kids_app/features/appointment_test/data/data_source/appointment_data_source.dart';
import 'package:i_smile_kids_app/features/appointment_test/data/models/appointment_model.dart';
import 'package:i_smile_kids_app/features/appointment_test/data/models/time_slot_model.dart';
import 'package:i_smile_kids_app/features/appointment_test/data/repo/appontment_repo.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource _remoteDataSource;

  AppointmentRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<TimeSlotModel>> getAvailableTimeSlots(
    String doctorId,
    DateTime date,
  ) {
    return _remoteDataSource.getAvailableTimeSlots(doctorId, date);
  }

  @override
  Future<bool> bookAppointment(AppointmentModel appointment) {
    return _remoteDataSource.bookAppointment(appointment);
  }

  @override
  Future<bool> updateTimeSlotAvailability(String timeSlotId, bool isAvailable) {
    return _remoteDataSource.updateTimeSlotAvailability(
      timeSlotId,
      isAvailable,
    );
  }

  @override
  Future<List<AppointmentModel>> getDoctorAppointments(
    String doctorId,
    DateTime date,
  ) {
    return _remoteDataSource.getDoctorAppointments(doctorId, date);
  }
}
