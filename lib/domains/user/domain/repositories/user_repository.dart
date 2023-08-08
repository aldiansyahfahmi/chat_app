import 'package:chat_app/domains/user/data/models/response/user_data_dto.dart';
import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<FailureResponse, Stream<UserDataEntity>>> getUserById();
  Future<Either<FailureResponse, Stream<List<UserDataDto>>>> getAllUsers();
}
