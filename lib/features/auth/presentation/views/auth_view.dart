  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:i_smile_kids_app/core/services/service_locator.dart';
  import 'package:i_smile_kids_app/features/auth/data/repo/auht_repo_impl.dart';
  import 'package:i_smile_kids_app/features/auth/presentation/manger/auth_cubit.dart';
  import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/auth_view_body.dart';

  class AuthView extends StatelessWidget {
    const AuthView({super.key});

    @override
    Widget build(BuildContext context) {
      return BlocProvider(
        create: (context) => AuthCubit(getIt.get<AuthRepositoryImpl>()),
        child: const Scaffold(body: AuthViewBody()),
      );
    }
  }
