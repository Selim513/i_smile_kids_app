import 'package:i_smile_kids_app/features/book_appointment/data/models/appointment_test_model.dart';

abstract class BookAppointmentRepository {
  Future<AppointmentDoctorAvailabilityModel> getDoctorAvailableTime({
    required String docId,
  });
  Future<String> bookAppointment({required BookAppointmentModel appointment});
  Future<List<BookAppointmentModel>> getPatientAppointments({
    required String patientId,
  });
  Future<void> cancelAppointment({
    required String appointmentId,
    required String doctorName,
    required String date,
    required String time,
  });
}
