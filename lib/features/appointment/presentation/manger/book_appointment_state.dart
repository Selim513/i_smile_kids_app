
import 'package:i_smile_kids_app/features/appointment/data/models/time_slot_model.dart';

abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class LoadingTimeSlots extends AppointmentState {}

class TimeSlotsLoaded extends AppointmentState {
  final List<TimeSlotModel> timeSlots;
  
  TimeSlotsLoaded(this.timeSlots);
}

class DateSelected extends AppointmentState {
  final DateTime selectedDate;
  
  DateSelected(this.selectedDate);
}

class TimeSlotSelected extends AppointmentState {
  final String timeSlot;
  final List<TimeSlotModel> availableTimeSlots;
  
  TimeSlotSelected(this.timeSlot, this.availableTimeSlots);
}

class BookingAppointment extends AppointmentState {}

class AppointmentBooked extends AppointmentState {}

class AppointmentError extends AppointmentState {
  final String message;
  
  AppointmentError(this.message);
}