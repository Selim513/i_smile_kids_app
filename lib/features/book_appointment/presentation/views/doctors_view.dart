import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/core/services/service_locator.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/features/book_appointment/data/repo/doctors_repo/docotrs_repo.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/manger/fetch_doctors_data_cubit/fetch_doctors_data_cubit.dart';
import 'package:i_smile_kids_app/features/book_appointment/presentation/views/widgets/doctors_view_body.dart';

class DoctorsVeiw extends StatelessWidget {
  const DoctorsVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomPrimaryAppbar(title: 'Doctors'),

      body: BlocProvider(
        create: (context) =>
            FetchDoctorsDataCubit(getIt.get<DocotrsDataRepo>())
              ..fetchDoctorsData(),
        child: const DoctorsViewBody(),
      ),
    );
  }
}
