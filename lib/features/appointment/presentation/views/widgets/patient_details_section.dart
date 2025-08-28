import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/custom_textform_field.dart';

class PatientDetails extends StatelessWidget {
  final String age;
  final String name;
  final TextEditingController problemController;
  final void Function(String)? onChanged;
  const PatientDetails({
    super.key,
    required this.problemController,
    required this.age,
    required this.name,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Patient Details', style: FontManger.blackBoldFont18),
        CustomTextFormField(
          readOnly: true,

          prefixIcon: Icons.person,
          title: name,
        ),
        CustomTextFormField(
          prefixIcon: Icons.cake_rounded,
          title: age,
          keyboardType: TextInputType.number,
        ),
        CustomTextFormField(
          onChanged: onChanged,
          controller: problemController,
          maxLines: 5,
          title: 'Write your problem',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please describe your problem';
            }
            return null;
          },
        ),
      ],
    );
  }
}
