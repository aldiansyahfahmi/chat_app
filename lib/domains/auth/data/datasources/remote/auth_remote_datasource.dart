import 'package:chat_app/domains/auth/data/models/body/sign_in_with_email_and_password_request_dto.dart';
import 'package:chat_app/domains/auth/data/models/body/sign_up_with_email_and_password_request_dto.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<bool> isUserLogged();
  Future<void> signUpWithEmailAndPassword(
      {required SignUpWithEmailAndPasswordRequestDto requestDto});
  Future<UserCredential> signInWithEmailAndPassword(
      {required SignInWithEmailAndPasswordRequestDto requestDto});
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirestoreService firestoreService = FirestoreService();
  final _auth = FirebaseAuth.instance;

  @override
  Future<bool> isUserLogged() async {
    try {
      final result = _auth.currentUser != null;
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword(
      {required SignUpWithEmailAndPasswordRequestDto requestDto}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: requestDto.email,
        password: requestDto.password,
      );
      if (credential.user != null) {
        await firestoreService.usersCollection
            .doc(requestDto.email)
            .set(requestDto.toJson());
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      {required SignInWithEmailAndPasswordRequestDto requestDto}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: requestDto.email,
        password: requestDto.password,
      );
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
