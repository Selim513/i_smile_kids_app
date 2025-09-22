import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/features/dashboard/data/repo/dashboard_repo.dart'; // استورد الـ repo
import 'package:i_smile_kids_app/features/dashboard/presentation/manger/dashboard_cubit.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/manger/dashboard_state.dart';

class PatientRewardView extends StatelessWidget {
  const PatientRewardView({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدم BlocProvider هنا لو الشاشة دي بتتفتح لوحدها
    // لو الـ DashboardCubit موجود فوقها في الشجرة، مش محتاجين BlocProvider
    return BlocProvider(
      create: (context) =>
          DashboardCubit(DashboardRepository()) // تأكد إنك بتمرر الـ repo صح
            ..fetchPendingPrizes(), // أول ما الشاشة تفتح، بنطلب البيانات
      child: Scaffold(
        appBar: CustomPrimaryAppbar(title: 'Patient Rewards List'),
        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DashboardError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            if (state is DashboardPendingPrizesLoaded) {
              if (state.prizes.isEmpty) {
                return const Center(
                  child: Text(
                    '"No prizes are waiting for delivery at the moment." ✅',
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(10.r),
                itemCount: state.prizes.length,
                itemBuilder: (context, index) {
                  final prize = state.prizes[index];
                  return Card(
                    color: ColorManager.background,
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    elevation: 3,

                    child: ListTile(
                      contentPadding: EdgeInsets.all(10.r),
                      leading: CircleAvatar(
                        backgroundImage: prize.patientPhotoURL != null
                            ? NetworkImage(prize.patientPhotoURL!)
                            : null,
                        child: prize.patientPhotoURL == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      title: Text(
                        prize.patientName,
                        style: FontManger.blackBoldFont18,
                      ),
                      subtitle: Text(
                        'Prize: ${prize.prizeName}',
                        style: FontManger.subTitleTextBold14,
                        textAlign: TextAlign.start,
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.success,
                        ),
                        onPressed: () {
                          // لما نضغط على الزرار، بننادي دالة الـ cubit
                          context.read<DashboardCubit>().claimPrize(prize.id);
                        },
                        child: Text(
                          'Claimed',
                          style: FontManger.whiteBoldFont20.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            // لو أي حالة تانية
            return const Center(child: Text('Please wait...'));
          },
        ),
      ),
    );
  }
}
