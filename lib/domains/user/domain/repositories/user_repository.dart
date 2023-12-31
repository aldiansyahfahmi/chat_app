import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<FailureResponse, Stream<UserDataEntity>>> getProfile();
  Future<Either<FailureResponse, Stream<List<UserDataEntity>>>> getAllUsers();
  Future<Either<FailureResponse, Stream<UserDataEntity>>> getUserById(
      {required String userId});
}
