import 'package:chat_app/shared_libraries/utils/constants/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final usersCollection =
      FirebaseFirestore.instance.collection(AppConstants.appCollection.users);
}
