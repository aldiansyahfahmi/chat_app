import 'package:chat_app/domains/account/domain/entities/response/user_response_entity.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AccountRepository {
  Future<Either<FailureResponse, User>> getUser();
  Future<Either<FailureResponse, Stream<UserResponseEntity>>> getUserById(
      {required String docId});
}
