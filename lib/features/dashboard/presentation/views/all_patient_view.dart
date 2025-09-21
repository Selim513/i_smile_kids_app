import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/manger/dashboard_cubit.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/manger/dashboard_state.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/widgets/dashboard_patient_appointment_container.dart';

class TotalPatientView extends StatefulWidget {
  const TotalPatientView({super.key});

  @override
  State<TotalPatientView> createState() => _TotalPatientViewState();
}

class _TotalPatientViewState extends State<TotalPatientView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DashboardCubit>().loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPrimaryAppbar(title: 'All Patient'),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DashboardLoaded) {
            return ListView.builder(
              itemCount: state.patients.length,
              itemBuilder: (context, index) {
                final users = state.patients[index];
                return Padding(
                  padding: EdgeInsetsGeometry.all(10.r),
                  child: DashboardPatientAppointmentContainer(
                    name: users.name,
                    age: users.age,
                    profileImage: users.photoURL ?? '',
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('Please Check your internet and try again layter !'),
            );
          }
        },
      ),
    );
  }
}
