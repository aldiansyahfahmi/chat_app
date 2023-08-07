import 'package:chat_app/shared_libraries/utils/constants/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCollection {
  static final firestore = FirebaseFirestore.instance;

  var usersCollection = firestore.collection(AppConstants.appCollection.users);
}
