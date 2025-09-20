import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/dashboard/data/repo/dashboard_repo.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/manger/dashboard_cubit.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/widgets/custom_dashboard_appbar.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/widgets/custom_dashboard_drawer.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/widgets/dashboard_view_body.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardCubit(DashboardRepository())..loadDashboard(),
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: CustomDashboardAppbar(),
        body: DashboardViewBody(),
      ),
    );
  }
}
