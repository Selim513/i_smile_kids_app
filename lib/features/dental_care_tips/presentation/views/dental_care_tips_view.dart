import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/core/services/service_locator.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/data/repo/dental_care_tips_repo_impl.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/presentation/manger/fetch_dental_care_tips_cubit.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/presentation/views/widgets/dental_tips_view_body.dart';

class DentalCareTipsView extends StatelessWidget {
  const DentalCareTipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchDentalCareTipsCubit(getIt.get<DentalCareTipsRepoImpl>())
            ..fetchDentalCareTipsData(),
      child: Scaffold(
        appBar: const CustomPrimaryAppbar(
          title: 'Dental Care Tips',
          leading: SizedBox(),
        ),
        body: DentalTipsViewBody(),
      ),
    );
  }
}
