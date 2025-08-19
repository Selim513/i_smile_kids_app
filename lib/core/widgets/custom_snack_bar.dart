import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

abstract class CustomSnackBar {
  static void errorSnackBar(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: FontManger.textFomrHintFont14 .copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void successSnackBar(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: FontManger.textFomrHintFont14.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void confrimEmailSnackBar(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: FontManger.textFomrHintFont14.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: ColorManager.textDark,
      ),
    );
  }
}