
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/appointment/data/models/appointment_model.dart';
import 'package:i_smile_kids_app/features/appointment/data/models/time_slot_model.dart';
import 'package:i_smile_kids_app/features/appointment/data/repo/appointment_repo_impl.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/manger/book_appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepositoryImpl appointmentrepo;

  AppointmentCubit(this.appointmentrepo) : super(AppointmentInitial());

  String? selectedTimeSlot;
  DateTime selectedDate = DateTime.now();
  List<TimeSlotModel> availableTimeSlots = [];

  void selectDate(DateTime date) {
    selectedDate = date;
    // إعادة تعيين الوقت المحدد عند تغيير التاريخ
    selectedTimeSlot = null;
    
    // emit state لإخفاء التوقيت المحدد في الـ UI
    emit(DateSelected(date));
    
    getAvailableTimeSlots();
  }

  void selectTimeSlot(String timeSlot) {
    selectedTimeSlot = timeSlot;
    emit(TimeSlotSelected(timeSlot, availableTimeSlots));
  }

  Future<void> getAvailableTimeSlots() async {
    emit(LoadingTimeSlots());
    try {
      const String doctorId = 'doctor_1';

      availableTimeSlots = await appointmentrepo.getAvailableTimeSlots(
        doctorId,
        selectedDate,
      );
      
      // التأكد من إرسال الـ timeSlots مع الـ state
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
      const String doctorId = 'doctor_1';

      final success = await appointmentrepo.bookAppointment(
        AppointmentModel(
          id: '', // خلي الـ repository يولد الـ ID
          doctorId: doctorId,
          patientUid: FirebaseAuth.instance.currentUser?.uid ?? '',
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
        // إعادة تعيين التوقيت المحدد بعد الحجز
        selectedTimeSlot = null;
        // تحديث المواعيد المتاحة بعد الحجز
        getAvailableTimeSlots();
      } else {
        emit(AppointmentError('Failed to book appointment'));
      }
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  // إضافة method لإعادة تعيين الحالة
  void resetSelection() {
    selectedTimeSlot = null;
    emit(AppointmentInitial());
  }
}