import 'package:chat_app/shared_libraries/utils/constants/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final firebaseFirestore = FirebaseFirestore.instance;

  final usersCollection =
      firebaseFirestore.collection(AppConstants.appCollection.users);

  final chatCollection =
      firebaseFirestore.collection(AppConstants.appCollection.chats);
}
