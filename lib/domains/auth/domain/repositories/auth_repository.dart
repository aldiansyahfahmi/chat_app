import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<FailureResponse, bool>> cachedToken({required String token});

  Future<Either<FailureResponse, String>> getToken();

  Future<Either<FailureResponse, bool>> removeUserData();
}
