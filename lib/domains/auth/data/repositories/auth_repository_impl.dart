import 'package:chat_app/domains/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:chat_app/domains/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({required this.authLocalDataSource});
  @override
  Future<Either<FailureResponse, bool>> cachedToken(
      {required String token}) async {
    try {
      await authLocalDataSource.cachedToken(token: token);
      return const Right(true);
    } on Exception catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.toString(),
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, String>> getToken() async {
    try {
      final response = await authLocalDataSource.getToken();
      return Right(response);
    } on Exception catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.toString(),
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, bool>> removeUserData() async {
    try {
      final response = await authLocalDataSource.removeUserData();

      return Right(
        response,
      );
    } on Exception catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.toString(),
          statusCode: 500,
        ),
      );
    }
  }
}
