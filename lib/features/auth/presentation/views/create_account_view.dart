import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/widgets/custom_auth_appbar.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/create_account_view_body.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAuthAppbar(title: 'Create Account'),
      body: CreateAccountViewBody(),
    );
  }
}
