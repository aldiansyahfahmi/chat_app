import 'package:chat_app/domains/auth/domain/entities/body/auth_with_email_and_password_request_entity.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<FailureResponse, bool>> isUserLogged();
  Future<Either<FailureResponse, bool>> signUpWithEmailAndPassword(
      {required AuthWithEmailAndPasswordRequestEntity requestEntity});
  Future<Either<FailureResponse, UserCredential>> signInWithEmailAndPassword(
      {required AuthWithEmailAndPasswordRequestEntity requestEntity});
  Future<Either<FailureResponse, NoParams>> signOut();
}
