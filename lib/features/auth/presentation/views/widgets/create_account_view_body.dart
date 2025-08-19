import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:i_smile_kids_app/core/widgets/custom_logo_container.dart';
import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_cubit.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/create_account_formfield_section.dart';

class CreateAccountViewBody extends StatelessWidget {
  const CreateAccountViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();

    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w),
        child: CustomScrollView(
          slivers: [
            // SliverToBoxAdapter(child: CreateAccountAppbarWidget()),
            SliverToBoxAdapter(child: Gap(20.h)),
            SliverToBoxAdapter(child: CustomLogoContainer(height: 80.h)),
            SliverToBoxAdapter(child: Gap(30.h)),
            // SliverToBoxAdapter(child: CreateAccountPickProfileImage()),
            SliverFillRemaining(
              hasScrollBody: false,
              child: CreateAccountFormFieldSection(cubit: cubit),
            ),
          ],
        ),
      ),
    );
  }
}
