import 'package:chat_app/domains/account/data/datasources/remote/account_remote_datasource.dart';
import 'package:chat_app/domains/account/domain/repositories/account_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource accountRemoteDataSource;

  AccountRepositoryImpl({required this.accountRemoteDataSource});

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
}
