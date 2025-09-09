import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/presentation/manger/fetch_dental_care_tips_cubit.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/presentation/manger/fetch_dental_care_tips_state.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/presentation/views/widgets/dental_tips_list_view_builder.dart';

class DentalTipsViewBody extends StatelessWidget {
  const DentalTipsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<FetchDentalCareTipsCubit, FetchDentalCareTipsState>(
          builder: (context, state) {
            if (state is FetchDentalCareTipsSuccess) {
              var data = state.tips;
              return DentalTipsListViewBuilder(data: data);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
