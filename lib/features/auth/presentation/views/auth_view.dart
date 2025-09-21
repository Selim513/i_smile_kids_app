import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/auth_view_body.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('===@@@@@@${FirebaseAuth.instance.currentUser?.displayName}');
    print('=Uid${FirebaseAuth.instance.currentUser?.uid}');
    print('===@@@@@@${FirebaseHelper.user?.displayName}');
    print('===@@@@@@${FirebaseHelper.user?.email}');
    print('===@@@@@@${FirebaseAuth.instance.currentUser?.email}');
    print('===@@@@@@${FirebaseHelper.user?.photoURL}');
    print('===@@@@@@${FirebaseHelper.user?.photoURL}');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AuthViewBody());
  }
}
