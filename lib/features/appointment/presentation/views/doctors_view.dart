import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/features/appointment/presentation/views/widgets/doctors_view_body.dart';

class DoctorsVeiw extends StatelessWidget {
  const DoctorsVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPrimaryAppbar(title: 'Doctors'),

      body: DoctorsViewBody(),
    );
  }
}
