import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/custom_textform_outline_border.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';

class CustomNationalityTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;

  const CustomNationalityTextFormField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () => showCountryPicker(
        moveAlongWithKeyboard: true,
        useSafeArea: true,
        context: context,
        onSelect: (Country country) {
          controller.text = country.name;
        },
      ),
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: FontManger.textFomrHintFont14,
        prefixIcon: const Icon(Icons.language, color: ColorManager.greyColor),
        labelText: labelText ?? 'Nationality',
        labelStyle: FontManger.meduimFontBlack14.copyWith(
          color: ColorManager.greyColor,
        ),
        floatingLabelStyle: FontManger.meduimFontBlack14.copyWith(
          color: ColorManager.secondary,
        ),
        fillColor: ColorManager.textDark.withValues(alpha: 0.1),
        filled: true,
        border: customOutLineBorders(),
        enabledBorder: customOutLineBorders(),
        focusedBorder: customOutLineBorders(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nationality is required';
        }
        return null;
      },
    );
  }
}

class CustomEmirateOfResidencyDropDownTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;

  const CustomEmirateOfResidencyDropDownTextFormField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
  });
  static final List<String> emirates = [
    'Abu Dhabi',
    'Dubai',
    'Sharjah',
    'Ajman',
    'Umm Al Quwain',
    'Ras Al Khaimah',
    'Fujairah',
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      borderRadius: BorderRadius.circular(20.r),
      dropdownColor: Colors.white,
      style: FontManger.meduimFontBlack14,

      // value: controller.text.isEmpty ? null : controller.text,
      items: emirates.map((emirate) {
        return DropdownMenuItem<String>(value: emirate, child: Text(emirate));
      }).toList(),
      onChanged: (value) {
        controller.text = value ?? '';
      },
      decoration: InputDecoration(
        hintText: hintText ?? 'Emirate of Residency',
        hintStyle: FontManger.textFomrHintFont14,
        prefixIcon: const Icon(Icons.home, color: ColorManager.greyColor),
        labelText: labelText,
        labelStyle: FontManger.meduimFontBlack14.copyWith(
          color: ColorManager.greyColor,
        ),
        floatingLabelStyle: FontManger.meduimFontBlack14.copyWith(
          color: ColorManager.secondary,
        ),
        fillColor: ColorManager.textDark.withValues(alpha: 0.1),
        filled: true,
        border: customOutLineBorders(),
        enabledBorder: customOutLineBorders(),
        focusedBorder: customOutLineBorders(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Emirate of Residency is required';
        }
        return null;
      },
    );
  }
}
//-

class ChildAgeDropDownFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;

  const ChildAgeDropDownFormField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
  });
  static final List<String> ages = List<String>.generate(
    16,
    (i) => (i + 3).toString(),
  );
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      borderRadius: BorderRadius.circular(20.r),
      dropdownColor: Colors.white,
      style: FontManger.meduimFontBlack14,

      // value: controller.text.isEmpty ? null : controller.text,
      items: ages.map((emirate) {
        return DropdownMenuItem<String>(value: emirate, child: Text(emirate));
      }).toList(),
      onChanged: (value) {
        controller.text = value ?? '';
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: FontManger.textFomrHintFont14,
        prefixIcon: const Icon(
          Icons.cake_rounded,
          color: ColorManager.greyColor,
        ),
        labelText: labelText ?? 'Age',
        labelStyle: FontManger.meduimFontBlack14.copyWith(
          color: ColorManager.greyColor,
        ),
        floatingLabelStyle: FontManger.meduimFontBlack14.copyWith(
          color: ColorManager.secondary,
        ),
        fillColor: ColorManager.textDark.withValues(alpha: 0.1),
        filled: true,
        border: customOutLineBorders(),
        enabledBorder: customOutLineBorders(),
        focusedBorder: customOutLineBorders(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Age is required';
        }
        return null;
      },
    );
  }
}

//-
