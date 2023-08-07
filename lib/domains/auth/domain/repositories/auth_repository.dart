import 'package:chat_app/domains/auth/domain/entities/body/sign_up_with_email_and_password_request_entity.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<FailureResponse, bool>> isUserLogged();

  Future<Either<FailureResponse, UserCredential>> signUpWithEmailAndPassword(
      {required SignUpWithEmailAndPasswordRequestEntity requestEntity});
}
