import 'package:chat_app/domains/account/data/models/response/user_response_dto.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AccountRemoteDataSource {
  Future<User> getUser();
  Future<Stream<UserResponseDto>> getUserById({required String docId});
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final FirestoreService firestoreService = FirestoreService();
  final _user = FirebaseAuth.instance;

  @override
  Future<User> getUser() async {
    try {
      final result = _user.currentUser!;
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Stream<UserResponseDto>> getUserById({required String docId}) async {
    try {
      final result = firestoreService.usersCollection.doc(docId).snapshots();
      return result.map(
        (event) => UserResponseDto.fromJson(event.data()!),
      );
    } catch (e) {
      rethrow;
    }
  }
}
