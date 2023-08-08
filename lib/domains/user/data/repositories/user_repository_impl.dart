import 'package:chat_app/domains/user/data/datasources/remote/user_remote_datasource.dart';
import 'package:chat_app/domains/user/data/mapper/user_mapper.dart';
import 'package:chat_app/domains/user/data/models/response/user_data_dto.dart';
import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:chat_app/domains/user/domain/repositories/user_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final UserMapper userMapper;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required this.userMapper,
  });

  @override
  Future<Either<FailureResponse, User>> getUser() async {
    try {
      final result = await userRemoteDataSource.getUser();
      return Right(result);
    } on FirebaseAuthException catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.message!,
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, Stream<UserDataEntity>>> getUserById() async {
    try {
      final result = await userRemoteDataSource.getUserById();
      return Right(
        userMapper.mapUserDataDtoToUserDataEntity(result),
      );
    } on FirebaseException {
      return const Left(
        FailureResponse(
          errorMessage: 'errorMessage',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, Stream<List<UserDataDto>>>>
      getAllUsers() async {
    try {
      final result = await userRemoteDataSource.getAllUser();
      return Right(result);
    } on FirebaseException {
      return const Left(
        FailureResponse(
          errorMessage: 'errorMessage',
          statusCode: 500,
        ),
      );
    }
  }
}
