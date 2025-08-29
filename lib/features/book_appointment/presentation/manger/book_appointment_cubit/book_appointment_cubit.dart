import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/models/appointment_test_model.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/repo/book_appointment_test_repo/appointment_test_repo.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/manger/book_appointment_cubit/book_appointment_cubit_state.dart';

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  final BookAppointmentRepository repository;

  BookAppointmentCubit({required this.repository})
    : super(BookAppointmentInitial());

  // جلب أوقات الطبيب المتاحة
  Future<void> fetchDoctorAvailableTime({required String docId}) async {
    emit(FetchDoctorTestAvailabilityLoading());
    try {
      final doctorAvailability = await repository.getDoctorAvailableTime(
        docId: docId,
      );
      emit(
        FetchDoctorTestAvailabilitySuccess(
          doctorAvailability: doctorAvailability,
        ),
      );
    } catch (e) {
      emit(FetchDoctorTestAvailabilityFailure(errorMessage: e.toString()));
    }
  }

  // حجز موعد
  Future<void> bookAppointment({
    required String doctorName,
    required String doctorId,
    required String date,
    required String time,
    required AppointmentPatientDetailsModel patientDetails,
  }) async {
    emit(BookAppointmentTestLoading());
    try {
      final appointment = BookAppointmentModel(
        doctorId: doctorId,
        doctorName: doctorName,
        date: date,
        time: time,
        patientDetails: patientDetails,
        status: 'confirmed',
        createdAt: DateTime.now(),
      );

      final successMessage = await repository.bookAppointment(
        appointment: appointment,
      );
      emit(BookAppointmentTestSuccess(successMessage: successMessage));
    } catch (e) {
      emit(BookAppointmentTestFailure(errorMessage: e.toString()));
    }
  }

  // جلب مواعيد المريض
  Future<void> fetchPatientAppointments({required String patientId}) async {
    emit(FetchPatientAppointmentTestsLoading());
    try {
      final appointments = await repository.getPatientAppointments(
        patientId: patientId,
      );
      emit(FetchPatientAppointmentTestsSuccess(appointments: appointments));
    } catch (e) {
      emit(FetchPatientAppointmentTestsFailure(errorMessage: e.toString()));
    }
  }

  // إلغاء موعد
  Future<void> cancelAppointment({
    required String appointmentId,
    required String doctorName,
    required String date,
    required String time,
  }) async {
    emit(CancelAppointmentTestLoading());
    try {
      await repository.cancelAppointment(
        appointmentId: appointmentId,
        doctorName: doctorName,
        date: date,
        time: time,
      );
      emit(CancelAppointmentTestSuccess());
    } catch (e) {
      emit(CancelAppointmentTestFailure(errorMessage: e.toString()));
    }
  }
}
