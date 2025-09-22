import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/dashboard/data/repo/dashboard_repo.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/manger/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository _repository;
  

  DashboardCubit(this._repository) : super(DashboardInitial());

  Future<void> loadDashboard() async {
    try {
      emit(DashboardLoading());

      // التحقق من المواعيد المتأخرة أولاً
      await _repository.checkAndUpdateMissedAppointments();

      // تحميل البيانات
      final todayAppointments = await _repository.getTodayAppointments();
      final allAppointment = await _repository.getAllAppointments();
      final statistics = await _repository.getPatientStatistics();
      final currentUser = await _repository.getCurrentDoctorUser();
      final allUsers=await _repository.getAllUsers();

      emit(
        DashboardLoaded(
          patients:allUsers ,
          allAppointment: allAppointment,
          todayAppointments: todayAppointments,
          statistics: statistics,
          currentUser: currentUser,
        ),
      );
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
    
  }

  Future<void> markAppointmentCompleted({
    required String appointmentId,
    String? notes,
  }) async {
    try {
      emit(AppointmentUpdating());

      await _repository.updateAppointmentStatus(
        appointmentId: appointmentId,
        status: 'completed',
        notes: notes,
      );

      emit(AppointmentUpdated('تم إكمال الزيارة بنجاح'));

      // إعادة تحميل البيانات
      loadDashboard();
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> cancelAppointment({
    required String appointmentId,
    required String doctorId,
    required String date,
    required String time,
    String? reason,
  }) async {
    try {
      emit(AppointmentUpdating());

      await _repository.cancelAppointmentFromDashboard(
        appointmentId: appointmentId,
        doctorId: doctorId,
        date: date,
        time: time,
        cancellationReason: reason,
      );

      emit(AppointmentUpdated('تم إلغاء الموعد بنجاح'));

      // إعادة تحميل البيانات
      loadDashboard();
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> markAppointmentMissed(String appointmentId) async {
    try {
      emit(AppointmentUpdating());

      await _repository.updateAppointmentStatus(
        appointmentId: appointmentId,
        status: 'missed',
      );

      emit(AppointmentUpdated('تم تحديث حالة الموعد إلى فائت'));

      // إعادة تحميل البيانات
      loadDashboard();
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> refreshDashboard() async {
    loadDashboard();
  }
  Future<void> fetchPendingPrizes() async {
        try {
          emit(DashboardLoading());
          final prizes = await _repository.getAllPendingPrizes();
          emit(DashboardPendingPrizesLoaded(prizes: prizes));
        } catch (e) {
          emit(DashboardError(e.toString()));
        }
      }

      // <<< دالة تأكيد استلام الجائزة >>>
      Future<void> claimPrize(String redeemedPrizeId) async {
        try {
          // ممكن تعمل حالة Updating هنا لو عايز
          await _repository.markPrizeAsClaimed(redeemedPrizeId);
          // بعد ما نحدّث الحالة، بنجيب القائمة من جديد عشان تختفي من الشاشة
          fetchPendingPrizes();
        } catch (e) {
          // ابعت الخطأ للواجهة
          emit(DashboardError("Failed to claim prize: ${e.toString()}"));
        }
      }
}
