import 'package:i_smile_kids_app/features/book_appointment/data/models/appointment_test_model.dart';

abstract class BookAppointmentState {}

class BookAppointmentInitial extends BookAppointmentState {}

// States for fetching doctor availability
class FetchDoctorTestAvailabilityLoading extends BookAppointmentState {}

class FetchDoctorTestAvailabilitySuccess extends BookAppointmentState {
  final AppointmentDoctorAvailabilityModel doctorAvailability;

  FetchDoctorTestAvailabilitySuccess({required this.doctorAvailability});
}

class FetchDoctorTestAvailabilityFailure extends BookAppointmentState {
  final String errorMessage;

  FetchDoctorTestAvailabilityFailure({required this.errorMessage});
}

// States for booking appointment
class BookAppointmentTestLoading extends BookAppointmentState {}

class BookAppointmentTestSuccess extends BookAppointmentState {
  final String successMessage;

  BookAppointmentTestSuccess({required this.successMessage});
}

class BookAppointmentTestFailure extends BookAppointmentState {
  final String errorMessage;

  BookAppointmentTestFailure({required this.errorMessage});
}

// States for patient appointments
class FetchPatientAppointmentTestsLoading extends BookAppointmentState {}

class FetchPatientAppointmentTestsSuccess extends BookAppointmentState {
  final List<BookAppointmentModel> appointments;

  FetchPatientAppointmentTestsSuccess({required this.appointments});
}

class FetchPatientAppointmentTestsFailure extends BookAppointmentState {
  final String errorMessage;

  FetchPatientAppointmentTestsFailure({required this.errorMessage});
}

// States for canceling appointment
class CancelAppointmentTestLoading extends BookAppointmentState {}

class CancelAppointmentTestSuccess extends BookAppointmentState {
  final String successMessage;

  CancelAppointmentTestSuccess({
    this.successMessage = 'Appointment canceled successfully',
  });
}

class CancelAppointmentTestFailure extends BookAppointmentState {
  final String errorMessage;

  CancelAppointmentTestFailure({required this.errorMessage});
}
