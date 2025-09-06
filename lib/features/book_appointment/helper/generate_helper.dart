import 'package:i_smile_kids_app/features/book_appointment/data/models/appointment_test_model.dart';
import 'package:intl/intl.dart';

abstract class GenerateHelper {
  static List<String> generateTimeSlotsForDay(
    String dayName,
    Map<String, DaySchedule> schedule,
  ) {
    List<String> slots = [];

    if (!schedule.containsKey(dayName)) {
      return slots;
    }

    final daySchedule = schedule[dayName]!;
    final startTime = DateFormat("HH:mm").parse(daySchedule.startTime);
    final endTime = DateFormat("HH:mm").parse(daySchedule.endTime);

    DateTime current = startTime;
    while (!current.isAfter(endTime)
    // current.isBefore(endTime)
    ) {
      slots.add(DateFormat("h:mm a").format(current));
      current = current.add(const Duration(minutes: 60));
    }
    return slots;
  }

  static List<String> filterAvailableSlots(
    List<String> allSlots,
    DateTime selectedDate,
    List<dynamic> bookedSlots,
  ) {
    List<String> availableSlots = [];
    DateTime now = DateTime.now();
    String today = DateFormat('yyyy-MM-dd').format(now);
    String selected = DateFormat('yyyy-MM-dd').format(selectedDate);

    for (String slot in allSlots) {
      DateTime slotDateTime = _parseSlotToDateTime(slot, selectedDate);

      if (selected == today) {
        if (slotDateTime.isAfter(now) && !bookedSlots.contains(slot)) {
          availableSlots.add(slot);
        }
      } else {
        if (!bookedSlots.contains(slot)) {
          availableSlots.add(slot);
        }
      }
    }

    return availableSlots;
  }

  static DateTime _parseSlotToDateTime(String slot, DateTime date) {
    try {
      DateFormat timeFormat = DateFormat("h:mm a");
      DateTime parsedTime = timeFormat.parse(slot);

      return DateTime(
        date.year,
        date.month,
        date.day,
        parsedTime.hour,
        parsedTime.minute,
      );
    } catch (e) {
      return DateTime(1900);
    }
  }
}
