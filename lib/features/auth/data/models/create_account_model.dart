import 'dart:io';

class CreateAccountModel {
  final File? profileImage;
  final String name;
  final String age;
  final String email;
  final String password;
  final String confirmPassword;
  final String nationality;
  final String emirateOfResidency;

  const CreateAccountModel({
    required this.age,
    this.profileImage,
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.nationality,
    required this.emirateOfResidency,
  });
}
