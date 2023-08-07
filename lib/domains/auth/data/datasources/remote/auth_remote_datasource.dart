import 'package:chat_app/domains/auth/data/models/body/auth_with_email_and_password_request_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<bool> isUserLogged();
  Future<UserCredential> signUpWithEmailAndPassword(
      {required AuthWithEmailAndPasswordRequestDto requestDto});
  Future<UserCredential> signInWithEmailAndPassword(
      {required AuthWithEmailAndPasswordRequestDto requestDto});
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
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
  Future<UserCredential> signUpWithEmailAndPassword(
      {required AuthWithEmailAndPasswordRequestDto requestDto}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: requestDto.email,
        password: requestDto.password,
      );
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      {required AuthWithEmailAndPasswordRequestDto requestDto}) async {
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
