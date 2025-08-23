import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/features/appointment_test/presentation/manger/book_appointment_cubit.dart';
import 'package:i_smile_kids_app/features/appointment_test/presentation/views/appointment_header_test.dart';
import 'package:i_smile_kids_app/features/appointment_test/presentation/views/available_time_section_test.dart';
import 'package:i_smile_kids_app/features/appointment_test/presentation/views/update_details_test.dart';

import '../manger/book_appointment_state.dart';

class BookAppointmentViewTest extends StatefulWidget {
  const BookAppointmentViewTest({super.key});

  @override
  State<BookAppointmentViewTest> createState() =>
      _BookAppointmentViewTestState();
}

class _BookAppointmentViewTestState extends State<BookAppointmentViewTest> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _problemController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _problemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPrimaryAppbar(title: 'Appointment'),
      body: BlocListener<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AppointmentBooked) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Appointment booked successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20.h,
                children: [
                  AppointmentHeaderDatePickedTest(),
                  AvailableTimeSectionTest(),
                  PatientDetailsTest(
                    nameController: _nameController,
                    ageController: _ageController,
                    problemController: _problemController,
                  ),
                  BlocBuilder<AppointmentCubit, AppointmentState>(
                    builder: (context, state) {
                      return CustomEleveatedButton(
                        onPress: state is BookingAppointment
                            ? () {}
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<AppointmentCubit>()
                                      .bookAppointment(
                                        patientName: _nameController.text
                                            .trim(),
                                        patientAge: int.parse(
                                          _ageController.text.trim(),
                                        ),
                                        problem: _problemController.text.trim(),
                                      );
                                }
                              },
                        child: state is BookingAppointment
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Book Appointment now',
                                style: FontManger.whiteBoldFont18,
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
