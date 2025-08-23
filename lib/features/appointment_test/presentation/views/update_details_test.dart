import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/features/auth/presentation/views/widgets/custom_textform_field.dart';

class PatientDetailsTest extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController problemController;
  
  const PatientDetailsTest({
    super.key,
    required this.nameController,
    required this.ageController,
    required this.problemController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Patient Details', style: FontManger.blackBoldFont18),
        CustomTextFormField(
          controller: nameController,
          prefixIcon: Icons.person,
          title: 'Full name',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter patient name';
            }
            return null;
          },
        ),
        CustomTextFormField(
          controller: ageController,
          prefixIcon: Icons.cake_rounded,
          title: 'Age',
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter patient age';
            }
            final age = int.tryParse(value);
            if (age == null || age <= 0) {
              return 'Please enter a valid age';
            }
            return null;
          },
        ),
        CustomTextFormField(
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