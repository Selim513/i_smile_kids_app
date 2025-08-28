import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/core/services/firebase_firestore_data_helper.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/manger/book_appointment_cubit.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/appointment_header.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/available_time_section.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/patient_details_section.dart';

import '../manger/book_appointment_state.dart';

class BookAppointmentView extends StatefulWidget {
  const BookAppointmentView({super.key});

  @override
  State<BookAppointmentView> createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView> {
  final TextEditingController _problemController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name;
  String? age;

  Future<void> _loadUserData() async {
    try {
      final uid = FirebaseHelper.user!.uid;
      var userData = await fetchUserDataFromFirestore(uid);

      if (userData != null) {
        setState(() {
          name = userData.name;
          age = userData.age;
        });
      }
    } catch (e) {
      throw 'There is an error please try again later';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _problemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      // extendBody: false,
      appBar: const CustomPrimaryAppbar(title: 'Appointment'),
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
              const SnackBar(
                content: Text('Appointment booked successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
          child: CustomScrollView(
            // reverse: true,
            slivers: [
              SliverToBoxAdapter(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20.h,
                    children: [
                      const AppointmentHeaderDatePicked(),
                      const AvailableTimeSection(),
                      PatientDetails(
                        name: name ?? "",
                        age: age ?? "",
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
                                            patientName: name ?? '',
                                            patientAge: age ?? '',
                                            problem: _problemController.text
                                                .trim(),
                                          );
                                    }
                                  },
                            child: state is BookingAppointment
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Book Appointment now',
                                    style: FontManger.whiteBoldFont20,
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 10.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
