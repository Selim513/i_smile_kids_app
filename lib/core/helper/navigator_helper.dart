import 'package:flutter/material.dart';

abstract class NavigatorHelper {
  static void push(BuildContext context, {required Widget screen}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static void pushReplaceMent(BuildContext context, {required Widget screen}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
