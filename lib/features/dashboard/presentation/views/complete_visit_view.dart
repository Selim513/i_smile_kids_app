import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/manger/dashboard_cubit.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/manger/dashboard_state.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/widgets/dashboard_patient_appointment_container.dart';

class CompleteVisitView extends StatefulWidget {
  const CompleteVisitView({super.key});

  @override
  State<CompleteVisitView> createState() => _CompleteVisitViewState();
}

class _CompleteVisitViewState extends State<CompleteVisitView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DashboardCubit>().loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPrimaryAppbar(
        title: 'Completed Visits',
      ), // تم تعديل العنوان
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoaded) {
            // الخطوة 1: نقوم بفلترة القائمة الرئيسية لإنشاء قائمة جديدة تحتوي فقط على الزيارات المكتملة
            final completedAppointments = state.allAppointment
                .where((appointment) => appointment.status == 'completed')
                .toList();

            // الخطوة 2: نتحقق إذا كانت القائمة المفلترة فارغة، ونعرض رسالة مناسبة
            if (completedAppointments.isEmpty) {
              return Center(
                child: Text(
                  "There are no completed visits at the moment.",
                  style: FontManger.meduimFontBlack14,
                ),
              );
            }

            // الخطوة 3: نستخدم القائمة المفلترة الجديدة في ListView.builder
            return ListView.builder(
              itemCount:
                  completedAppointments.length, // العدد هو طول القائمة الجديدة
              itemBuilder: (context, index) {
                // نأخذ بيانات الزيارة من القائمة الجديدة
                var appointment = completedAppointments[index];
                var userdata = appointment.patientDetails;

                // نفترض أن userdata يحتوي على حقول مثل name و age
                return Padding(
                  padding: EdgeInsetsGeometry.all(10.r),
                  child: DashboardPatientAppointmentContainer(
                    name: userdata.name, // مثال
                    age: userdata.age, // مثال
                    status: appointment.status,
                    profileImage: userdata.profileImage??'',

                    // يمكنك إضافة أي بيانات أخرى هنا
                  ),
                );
              },
            );
          } else if (state is DashboardError) {
            return Center(
              child: Text(
                'Check your internet and try again later !',
                style: FontManger.blackBoldFont18.copyWith(
                  color: ColorManager.error,
                ),
              ),
            );
          } else {
            // حالة التحميل (Loading)
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
