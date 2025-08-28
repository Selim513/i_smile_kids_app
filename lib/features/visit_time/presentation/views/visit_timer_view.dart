import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/features/visit_time/presentation/manger/fetch_next_visit_details_cubit.dart';
import 'package:i_smile_kids_app/features/visit_time/presentation/views/widgets/next_visit_view_body.dart';

class NextVisitTimeView extends StatelessWidget {
  const NextVisitTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchNextVisitDetailsCubit()..fetchNextVisitDetails(),
      child: const Scaffold(
        appBar: CustomPrimaryAppbar(title: 'Your next visit'),

        body: NextVisitTimeViewBody(),
      ),
    );
  }
}
