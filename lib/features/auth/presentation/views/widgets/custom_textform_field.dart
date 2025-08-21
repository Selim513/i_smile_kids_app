import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/custom_textform_outline_border.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.validator,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    // required this.hintText,
    this.prefixIcon,
    required this.title,
    this.maxLines, this.readOnly,
  });

  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  // final String hintText;
  final IconData? prefixIcon;
  final String title;
  final int? maxLines;
  final bool? readOnly;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly ?? false,
      maxLines: widget.maxLines ?? 1,
      cursorColor: ColorManager.textDark,
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _isObscure,

      decoration: InputDecoration(
        labelText: widget.title,
        labelStyle: FontManger.meduimFontBlack14.copyWith(
          color: ColorManager.greyColor,
        ),
        floatingLabelStyle: FontManger.meduimFontBlack14.copyWith(
          color: ColorManager.secondary,
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              )
            : null,
        prefixIcon: Icon(widget.prefixIcon, color: Colors.grey),
        // hintText: widget.hintText,
        // hintStyle: FontManger.textFomrHintFont14,
        fillColor: ColorManager.textDark.withValues(alpha: 0.1),
        filled: true,
        border: customOutLineBorders(),
        enabledBorder: customOutLineBorders(),
        focusedBorder: customOutLineBorders(),
      ),
    );
  }
}
