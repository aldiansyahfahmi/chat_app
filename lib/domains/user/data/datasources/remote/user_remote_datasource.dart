import 'package:chat_app/domains/user/data/models/response/user_data_dto.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRemoteDataSource {
  Future<Stream<UserDataDto>> getUserById();
  Future<Stream<List<UserDataDto>>> getAllUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuth _user = FirebaseAuth.instance;

  @override
  Future<Stream<UserDataDto>> getUserById() async {
    try {
      final currentUser = _user.currentUser;
      final result =
          _firestoreService.usersCollection.doc(currentUser!.email).snapshots();
      return result.map(
        (event) => UserDataDto.fromJson(event.data()!),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Stream<List<UserDataDto>>> getAllUser() async {
    try {
      final currentUser = _user.currentUser;
      final result = _firestoreService.usersCollection
          .where('email', isNotEqualTo: currentUser!.email)
          .snapshots();
      return result.map(
        (event) => List<UserDataDto>.from(
          event.docs.map(
            (e) => UserDataDto.fromJson(e.data()),
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
