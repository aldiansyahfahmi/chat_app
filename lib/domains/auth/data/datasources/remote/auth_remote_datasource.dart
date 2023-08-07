import 'package:chat_app/domains/auth/data/models/body/auth_with_email_and_password_request_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<bool> isUserLogged();
  Future<UserCredential> signUpWithEmailAndPassword(
      {required AuthWithEmailAndPasswordRequestDto requestDto});
  Future<UserCredential> signInWithEmailAndPassword(
      {required AuthWithEmailAndPasswordRequestDto requestDto});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<bool> isUserLogged() async {
    try {
      final result = FirebaseAuth.instance.currentUser != null;
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword(
      {required AuthWithEmailAndPasswordRequestDto requestDto}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: requestDto.email,
        password: requestDto.password,
      );
      return credential;
    } catch (e) {
      rethrow;
    }
  }
}
