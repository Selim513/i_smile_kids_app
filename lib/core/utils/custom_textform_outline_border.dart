import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';

OutlineInputBorder customOutLineBorders({Color? color, double? circular}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(circular ?? 15)),
    borderSide: BorderSide(color: color ?? ColorManager.border),
  );
}
