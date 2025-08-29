import 'package:flutter/material.dart';

class BookAppointmentTimeSelector extends StatelessWidget {
  final List<String> slots;
  final String? selectedTime;
  final Function(String) onTimeChanged;

  const BookAppointmentTimeSelector({
    super.key,
    required this.slots,
    this.selectedTime,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(slots.length, (index) {
        final timeSlot = slots[index];
        final isSelected = selectedTime == timeSlot;

        return GestureDetector(
          onTap: () {
            onTimeChanged(timeSlot);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.green : Colors.white,
              border: Border.all(
                color: isSelected ? Colors.green : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              timeSlot,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }),
    );
  }
}
