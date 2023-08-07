import 'package:chat_app/domains/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:chat_app/domains/auth/data/mapper/auth_mapper.dart';
import 'package:chat_app/domains/auth/domain/entities/body/sign_up_with_email_and_password_request_entity.dart';
import 'package:chat_app/domains/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthMapper authMapper;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authMapper,
  });

  @override
  Future<Either<FailureResponse, bool>> isUserLogged() async {
    try {
      final result = await authRemoteDataSource.isUserLogged();
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
  Future<Either<FailureResponse, UserCredential>> signUpWithEmailAndPassword(
      {required SignUpWithEmailAndPasswordRequestEntity requestEntity}) async {
    try {
      final credential = await authRemoteDataSource.signUpWithEmailAndPassword(
        requestDto: authMapper
            .mapSignUpWithEmailAndPasswordRequestEntityToSignUpWithEmailAndPasswordRequestDto(
          requestEntity,
        ),
      );
      return Right(credential);
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
