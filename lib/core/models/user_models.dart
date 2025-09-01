import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final int? totalBrushing;
  // final String nationality;
  // final String emirateOfResidency;
  final String age;
  final String? photoURL;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.totalBrushing,
    required this.uid,
    required this.name,
    required this.email,
    // required this.nationality,
    // required this.emirateOfResidency,
    required this.age,
    this.photoURL,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      totalBrushing: (map['brushing_data'] != null)
          ? (map['brushing_data']['total_sessions'] ?? 0)
          : 0,
      // nationality: map['nationality'] ?? '',
      // emirateOfResidency: map['emirateOfResidency'] ?? '',
      age: map['age'] ?? '',
      photoURL: map['photoURL'],
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'total_sessions': totalBrushing,
      // 'nationality': nationality,
      // 'emirateOfResidency': emirateOfResidency,
      'age': age,
      'photoURL': photoURL,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
