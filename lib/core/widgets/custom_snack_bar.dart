import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

abstract class CustomSnackBar {
  static void errorSnackBar(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: FontManger.textFomrHintFont14.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void warningSnackBar(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: FontManger.textFomrHintFont14.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: ColorManager.warning,
      ),
    );
  }

  static void successSnackBar(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,

        content: Text(
          message,
          style: FontManger.textFomrHintFont14.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void brushingTimerEnd(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(25),
        ),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
        content: Column(
          children: [
            Text('Well Done Ahmed !', style: FontManger.whiteBoldFont20),
            Text(
              'You earned +100 point 🎉',
              style: FontManger.meduimFontBlack14.copyWith(
                color: ColorManager.secondary,
              ),
            ),
          ],
        ),
        backgroundColor: ColorManager.success,
      ),
    );
  }

  static void confrimEmailSnackBar(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,

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
