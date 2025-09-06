import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/core/services/firebase_firestore_data_helper.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/core/widgets/custom_snack_bar.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/data_source/appointment_data_source_test.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/models/appointment_test_model.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/models/doctors_model.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/repo/book_appointment_test_repo/appointment_test_repo_impl.dart';
import 'package:i_smile_kids_app/features/book_appointment/helper/generate_helper.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/manger/book_appointment_cubit/book_appointment_cubit.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/manger/book_appointment_cubit/book_appointment_cubit_state.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/views/widgets/appointment_header_date_picked_test.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/views/widgets/doctor_available_time_section.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/views/widgets/patient_appointment_details.dart';
import 'package:intl/intl.dart';

class PatientAppointmentView extends StatefulWidget {
  const PatientAppointmentView({super.key, required this.docData});
  final DoctorsModel docData;

  @override
  State<PatientAppointmentView> createState() => _PatientAppointmentViewState();
}

class _PatientAppointmentViewState extends State<PatientAppointmentView> {
  DateTime selectedDate = DateTime.now();
  String? selectedTime;
  late String name;
  late String age;
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

  final TextEditingController problemController = TextEditingController();

  /// Refresh selected date
  void onDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
      selectedTime = null;
    });
  }

  /// Update selected time
  void onTimeChanged(String time) {
    setState(() {
      selectedTime = time;
    });
  }

  /// Check validate From
  bool validateForm() {
    if (selectedTime == null) {
      CustomSnackBar.errorSnackBar('Please select a time', context);
      return false;
    }
    if (problemController.text.isEmpty) {
      CustomSnackBar.errorSnackBar('Please describe the problem', context);
      return false;
    }
    return true;
  }

  /// date format YYYY-MM-DD
  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookAppointmentCubit>(
      create: (context) => BookAppointmentCubit(
        repository: BookAppointmentRepositoryImpl(
          remoteDataSource: AppointmentRemoteDataSourceTestImpl(
            firestore: FirebaseHelper.firebaseFirestore,
          ),
        ),
      )..fetchDoctorAvailableTime(docId: widget.docData.docId),
      child: Scaffold(
        appBar: const CustomPrimaryAppbar(title: 'Appointment'),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: SingleChildScrollView(
            child: BlocConsumer<BookAppointmentCubit, BookAppointmentState>(
              listener: (context, state) {
                if (state is BookAppointmentTestSuccess) {
                  CustomSnackBar.successSnackBar(state.successMessage, context);
                  Navigator.pop(context);
                } else if (state is BookAppointmentTestFailure) {
                  CustomSnackBar.errorSnackBar(state.errorMessage, context);
                  print(state.errorMessage);
                }
              },
              builder: (context, state) {
                if (state is FetchDoctorTestAvailabilitySuccess) {
                  final doctorData = state.doctorAvailability;
                  final workingDays = doctorData.workingDays;

                  /// Get the selected day
                  String dayName = DateFormat('EEEE').format(selectedDate);

                  /// Create Slots Based on the day
                  final slots = GenerateHelper.generateTimeSlotsForDay(
                    dayName,
                    doctorData.schedule,
                  );

                  String formattedDate = formatDate(selectedDate);
                  final availableSlots = GenerateHelper.filterAvailableSlots(
                    slots,
                    selectedDate,
                    doctorData.bookedSlots[formattedDate] ?? [],
                  );

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      PatientAppointmentHeaderDatePicked(
                        workingDays: workingDays,
                        onDateChanged: onDateChanged,
                      ),
                      SizedBox(height: 20.h),
                      DoctorAvailableTimeSection(
                        slots: availableSlots,
                        selectedDate: selectedDate,
                        selectedTime: selectedTime,
                        onTimeChanged: onTimeChanged,
                      ),
                      SizedBox(height: 20.h),
                      PatientAppointmentDetails(
                        age: age,
                        name: name,
                        problemController: problemController,
                      ),
                      SizedBox(height: 20.h),
                      CustomEleveatedButton(
                        onPress: () {
                          if (validateForm()) {
                            final patientDetails =
                                AppointmentPatientDetailsModel(
                                  name: name,
                                  age: age,
                                  problem: problemController.text,
                                );

                            context
                                .read<BookAppointmentCubit>()
                                .bookAppointment(
                                  doctorId: widget.docData.docId,
                                  doctorName: widget.docData.docFullName,
                                  date: formattedDate,
                                  time: selectedTime!,
                                  patientDetails: patientDetails,
                                );
                          }
                        },
                        child: state is BookAppointmentTestLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Book Appointment now',
                                style: FontManger.whiteBoldFont20,
                              ),
                      ),
                    ],
                  );
                } else if (state is FetchDoctorTestAvailabilityFailure) {
                  return Center(child: Text(state.errorMessage));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    problemController.dispose();
    super.dispose();
  }
}
