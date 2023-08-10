import 'package:chat_app/domains/user/data/datasources/remote/user_remote_datasource.dart';
import 'package:chat_app/domains/user/data/mapper/user_mapper.dart';
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
  Future<Either<FailureResponse, Stream<UserDataEntity>>> getProfile() async {
    try {
      final result = await userRemoteDataSource.getProfile();
      return Right(
        userMapper.mapStreamUserDataDtoToStreamUserDataEntity(result),
      );
    } on FirebaseException catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.message!,
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, Stream<List<UserDataEntity>>>>
      getAllUsers() async {
    try {
      final result = await userRemoteDataSource.getAllUser();
      return Right(userMapper.mapStreamUserDataDtoToStreamEntity(result));
    } on FirebaseException catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.message!,
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, Stream<UserDataEntity>>> getUserById(
      {required String userId}) async {
    try {
      final result = await userRemoteDataSource.getUserById(userId: userId);
      return Right(
        userMapper.mapStreamUserDataDtoToStreamUserDataEntity(result),
      );
    } on FirebaseException catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.message!,
          statusCode: 500,
        ),
      );
    }
  }
}
