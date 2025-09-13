import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/core/api/api_services/api_services.dart';
import 'package:i_smile_kids_app/core/widgets/custom_elevated_button.dart';
import 'package:i_smile_kids_app/features/book_appointment_api/data/data_source/remote_data_source/get_doctor_list_data_source.dart';
import 'package:i_smile_kids_app/features/book_appointment_api/presentation/manger/get_doctor_cubit.dart';
import 'package:i_smile_kids_app/features/book_appointment_api/presentation/manger/get_doctor_state.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetDoctorCubit(GetDoctorListDataSourceImpl(ApiServices(Dio())))
            ..getDoctorList(),
      child: Scaffold(
        appBar: AppBar(title: Text('Test')),
        body: BlocListener<GetDoctorCubit, GetDoctorState>(
          listener: (context, state) {
            if (state is GetDoctorSuccess) {
              print("----------${state.doctorList.length}");
            } else if (state is GetDoctorFailure) {
              print("---------Faiiiil--${state.errMessage}");
            }
          },
          child: Column(
            children: [
              CustomEleveatedButton(title: 'Get Doctors', onPress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
