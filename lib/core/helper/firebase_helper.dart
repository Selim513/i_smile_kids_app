import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_smile_kids_app/core/services/service_locator.dart';

abstract class FirebaseHelper {
  static User? user = FirebaseAuth.instance.currentUser;
  static FirebaseAuth userAuth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = getIt.get<FirebaseFirestore>();
}
