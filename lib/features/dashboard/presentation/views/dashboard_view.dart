import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/widgets/custom_dashboard_appbar.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/widgets/custom_dashboard_drawer.dart';
import 'package:i_smile_kids_app/features/dashboard/presentation/views/widgets/dashboard_view_body.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomDashboardAppbar(),
      body: DashboardViewBody(),
    );
  }
}
