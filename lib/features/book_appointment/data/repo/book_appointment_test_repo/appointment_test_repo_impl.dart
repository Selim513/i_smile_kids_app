import 'package:i_smile_kids_app/features/book_appointment/data/data_source/appointment_data_source_test.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/models/appointment_test_model.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/repo/book_appointment_test_repo/appointment_test_repo.dart';

class BookAppointmentRepositoryImpl implements BookAppointmentRepository {
  final BookAppointmentRemoteDataSource remoteDataSource;

  BookAppointmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AppointmentDoctorAvailabilityModel> getDoctorAvailableTime({
    required String docId,
  }) async {
    try {
      return await remoteDataSource.getDoctorAvailableTime(docId: docId);
    } catch (e) {
      throw Exception('Repository availableTime Error: ${e.toString()}');
    }
  }

  @override
  Future<String> bookAppointment({
    required BookAppointmentModel appointment,
  }) async {
    try {
      return await remoteDataSource.bookAppointment(appointment: appointment);
    } catch (e) {
      throw Exception('Repository bookAppointment Error: ${e.toString()}');
    }
  }

  @override
  Future<List<BookAppointmentModel>> getPatientAppointments({
    required String patientId,
  }) async {
    try {
      return await remoteDataSource.getPatientAppointments(
        patientId: patientId,
      );
    } catch (e) {
      throw Exception(
        'Repository getPatientAppointment Error: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> cancelAppointment({
    required String appointmentId,
    required String doctorName,
    required String date,
    required String time,
  }) async {
    try {
      return await remoteDataSource.cancelAppointment(
        appointmentId: appointmentId,
        doctorName: doctorName,
        date: date,
        time: time,
      );
    } catch (e) {
      throw Exception('Repository cancel appointment Error: ${e.toString()}');
    }
  }
}
