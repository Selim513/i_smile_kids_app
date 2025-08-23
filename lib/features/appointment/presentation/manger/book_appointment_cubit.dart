// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:i_smile_kids_app/features/appointment/data/models/appointment_model.dart';
// import 'package:i_smile_kids_app/features/appointment/data/models/time_slot_model.dart';
// import 'package:i_smile_kids_app/features/appointment/data/repo/appointment_repo_impl.dart';
// import 'package:i_smile_kids_app/features/appointment/presentation/manger/book_appointment_state.dart';

// class AppointmentCubit extends Cubit<AppointmentState> {
//   final AppointmentRepositoryImpl appointmentrepo;

//   AppointmentCubit(this.appointmentrepo) : super(AppointmentInitial());

//   String? selectedTimeSlot;
//   DateTime selectedDate = DateTime.now();
//   List<TimeSlotModel> availableTimeSlots = [];

//   void selectDate(DateTime date) {
//     selectedDate = date;
//     // إعادة تعيين الوقت المحدد عند تغيير التاريخ
//     selectedTimeSlot = null;

//     // emit state لإخفاء التوقيت المحدد في الـ UI
//     emit(DateSelected(date));

//     getAvailableTimeSlots();
//   }

//   void selectTimeSlot(String timeSlot) {
//     selectedTimeSlot = timeSlot;
//     emit(TimeSlotSelected(timeSlot, availableTimeSlots));
//   }

//   Future<void> getAvailableTimeSlots() async {
//     emit(LoadingTimeSlots());
//     try {
//       const String doctorId = 'doctor_1';

//       availableTimeSlots = await appointmentrepo.getAvailableTimeSlots(
//         doctorId,
//         selectedDate,
//       );

//       // التأكد من إرسال الـ timeSlots مع الـ state
//       emit(TimeSlotsLoaded(availableTimeSlots));
//     } catch (e) {
//       emit(AppointmentError(e.toString()));
//     }
//   }

//   // Future<void> bookAppointment({
//   //   required String patientName,
//   //   required String patientAge,
//   //   required String problem,
//   // }) async {
//   //   if (selectedTimeSlot == null) {
//   //     emit(AppointmentError('Please select a time slot'));
//   //     return;
//   //   }

//   //   emit(BookingAppointment());
//   //   try {
//   //     const String doctorId = 'doctor_1';

//   //     final success = await appointmentrepo.bookAppointment(
//   //       AppointmentModel(
//   //         id: '', // خلي الـ repository يولد الـ ID
//   //         doctorId: doctorId,
//   //         patientUid: FirebaseAuth.instance.currentUser?.uid ?? '',
//   //         patientName: patientName,
//   //         patientAge: patientAge,
//   //         problem: problem,
//   //         appointmentDate: selectedDate,
//   //         timeSlot: selectedTimeSlot!,
//   //         status: AppointmentStatus.pending,
//   //         createdAt: DateTime.now(),
//   //       ),
//   //     );

//   //     if (success) {
//   //       emit(AppointmentBooked());
//   //       // إعادة تعيين التوقيت المحدد بعد الحجز
//   //       selectedTimeSlot = null;
//   //       // تحديث المواعيد المتاحة بعد الحجز
//   //       getAvailableTimeSlots();
//   //     } else {
//   //       emit(AppointmentError('Failed to book appointment'));
//   //     }
//   //   } catch (e) {
//   //     emit(AppointmentError(e.toString()));
//   //   }
//   // }
//   Future<void> bookAppointment({
//     required String patientName,
//     required String patientAge,
//     required String problem,
//   }) async {
//     if (selectedTimeSlot == null) {
//       emit(AppointmentError('Please select a time slot'));
//       return;
//     }

//     emit(BookingAppointment());
//     try {
//       const String doctorId = 'doctor_1';
//       final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

//       // 🔹 جلب المواعيد الحالية للمستخدم
//       final userAppointments = await appointmentrepo.getUserAppointments();
//       // لو في أي موعد سابق، نلغي أول موعد تلقائياً
//       if (userAppointments.isNotEmpty) {
//         await appointmentrepo.cancelAppointment(userAppointments[0].id);
//       }

//       // 🔹 عمل الحجز الجديد
//       final success = await appointmentrepo.bookAppointment(
//         AppointmentModel(
//           id: '', // خلي الـ repository يولد الـ ID
//           doctorId: doctorId,
//           patientUid: userId,
//           patientName: patientName,
//           patientAge: patientAge,
//           problem: problem,
//           appointmentDate: selectedDate,
//           timeSlot: selectedTimeSlot!,
//           status: AppointmentStatus.pending,
//           createdAt: DateTime.now(),
//         ),
//       );

//       if (success) {
//         emit(AppointmentBooked());
//         selectedTimeSlot = null;
//         getAvailableTimeSlots(); // تحديث التوافر بعد الحجز
//       } else {
//         emit(AppointmentError('Failed to book appointment'));
//       }
//     } catch (e) {
//       emit(AppointmentError(e.toString()));
//     }
//   }

//   // إضافة method لإعادة تعيين الحالة
//   void resetSelection() {
//     selectedTimeSlot = null;
//     emit(AppointmentInitial());
//   }
// }
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
    required String patientAge,
    required String problem,
  }) async {
    if (selectedTimeSlot == null) {
      emit(AppointmentError('Please select a time slot'));
      return;
    }

    emit(BookingAppointment());
    try {
      const String doctorId = 'doctor_1';
      final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      // 🔹 جلب المواعيد الحالية للمستخدم
      final userAppointments = await appointmentrepo.getUserAppointments();
      // لو في أي موعد سابق، نلغي أول موعد تلقائياً
      if (userAppointments.isNotEmpty) {
        await appointmentrepo.cancelAppointment(userAppointments[0].id);
      }

      // ✅ إنشاء التاريخ والوقت الصحيح للموعد
      final DateTime appointmentDateTime = _createAppointmentDateTime(
        selectedDate,
        selectedTimeSlot!,
      );

      // 🔹 عمل الحجز الجديد
      final success = await appointmentrepo.bookAppointment(
        AppointmentModel(
          id: '', // خلي الـ repository يولد الـ ID
          doctorId: doctorId,
          patientUid: userId,
          patientName: patientName,
          patientAge: patientAge,
          problem: problem,
          appointmentDate:
              appointmentDateTime, // ✅ استخدام التاريخ والوقت الصحيح
          timeSlot: selectedTimeSlot!,
          status: AppointmentStatus.pending,
          createdAt: DateTime.now(), // ✅ هذا للـ tracking فقط
        ),
      );

      if (success) {
        emit(AppointmentBooked());
        selectedTimeSlot = null;
        getAvailableTimeSlots(); // تحديث التوافر بعد الحجز
      } else {
        emit(AppointmentError('Failed to book appointment'));
      }
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  // ✅ Helper method لإنشاء التاريخ والوقت الصحيح
  DateTime _createAppointmentDateTime(DateTime date, String timeSlot) {
    final timeParts = timeSlot.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  // إضافة method لإعادة تعيين الحالة
  void resetSelection() {
    selectedTimeSlot = null;
    emit(AppointmentInitial());
  }
}
