import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/widgets/custom_auth_appbar.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAuthAppbar(title: 'Login'),
      body: LoginViewBody(),
    );
  }
}
