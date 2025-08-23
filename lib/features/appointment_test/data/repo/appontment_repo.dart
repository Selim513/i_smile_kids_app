import 'package:i_smile_kids_app/features/appointment_test/data/models/appointment_model.dart';
import 'package:i_smile_kids_app/features/appointment_test/data/models/time_slot_model.dart';

abstract class AppointmentRepository {
  Future<List<TimeSlotModel>> getAvailableTimeSlots(String doctorId, DateTime date);
  Future<bool> bookAppointment(AppointmentModel appointment);
  Future<bool> updateTimeSlotAvailability(String timeSlotId, bool isAvailable);
  Future<List<AppointmentModel>> getDoctorAppointments(String doctorId, DateTime date);
}