import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class CustomProfilePersonalDetailsRow extends StatelessWidget {
  const CustomProfilePersonalDetailsRow({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: FontManger.textFomrHintFont14),
        const Spacer(),
        Text(value, style: FontManger.meduimFontBlack14),
      ],
    );
  }
}
