import 'package:chat_app/domains/account/data/datasources/remote/account_remote_datasource.dart';
import 'package:chat_app/domains/account/data/mapper/account_mapper.dart';
import 'package:chat_app/domains/account/domain/entities/response/user_response_entity.dart';
import 'package:chat_app/domains/account/domain/repositories/account_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource accountRemoteDataSource;
  final AccountMapper accountMapper;

  AccountRepositoryImpl({
    required this.accountRemoteDataSource,
    required this.accountMapper,
  });

  @override
  Future<Either<FailureResponse, User>> getUser() async {
    try {
      final result = await accountRemoteDataSource.getUser();
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
  Future<Either<FailureResponse, Stream<UserResponseEntity>>> getUserById(
      {required String docId}) async {
    try {
      final result = await accountRemoteDataSource.getUserById(docId: docId);
      return Right(
        accountMapper.mapUserResponseDtoToUserResponseEntity(result),
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
}
