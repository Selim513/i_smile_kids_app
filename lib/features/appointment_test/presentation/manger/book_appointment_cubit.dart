import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/appointment_test/data/models/appointment_model.dart';
import 'package:i_smile_kids_app/features/appointment_test/data/models/time_slot_model.dart';
import 'package:i_smile_kids_app/features/appointment_test/data/repo/appointment_repo_impl.dart';
import 'package:i_smile_kids_app/features/appointment_test/presentation/manger/book_appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepositoryImpl appointmentrepo;

  AppointmentCubit(this.appointmentrepo) : super(AppointmentInitial());

  String? selectedTimeSlot;

  DateTime selectedDate = DateTime.now();
  List<TimeSlotModel> availableTimeSlots = [];

  void selectDate(DateTime date) {
    selectedDate = date;
    getAvailableTimeSlots();
  }

  void selectTimeSlot(String timeSlot) {
    selectedTimeSlot = timeSlot;
    emit(TimeSlotSelected(timeSlot));
  }

  Future<void> getAvailableTimeSlots() async {
    emit(LoadingTimeSlots());
    try {
      // هنا تحط doctorId من المكان اللي بتجيبه منه
      const String doctorId = 'doctor_1'; // استبدل ده بالـ doctor ID الحقيقي

      availableTimeSlots = await appointmentrepo.getAvailableTimeSlots(
        doctorId,
        selectedDate,
      );
      emit(TimeSlotsLoaded(availableTimeSlots));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  Future<void> bookAppointment({
    required String patientName,
    required int patientAge,
    required String problem,
  }) async {
    if (selectedTimeSlot == null) {
      emit(AppointmentError('Please select a time slot'));
      return;
    }

    emit(BookingAppointment());
    try {
      const String doctorId = 'doctor_1'; // استبدل ده بالـ doctor ID الحقيقي

      final success = await appointmentrepo.bookAppointment(
        AppointmentModel(
          id: '1',
          doctorId: doctorId,
          patientName: patientName,
          patientAge: patientAge,
          problem: problem,
          appointmentDate: selectedDate,
          timeSlot: selectedTimeSlot!,
          status: AppointmentStatus.pending,
          createdAt: DateTime.now(),
        ),
      );

      if (success) {
        emit(AppointmentBooked());
        // تحديث المواعيد المتاحة بعد الحجز
        getAvailableTimeSlots();
      } else {
        emit(AppointmentError('Failed to book appointment'));
      }
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }
}
