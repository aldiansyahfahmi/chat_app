import 'package:chat_app/domains/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:chat_app/domains/auth/data/mapper/auth_mapper.dart';
import 'package:chat_app/domains/auth/domain/entities/body/auth_with_email_and_password_request_entity.dart';
import 'package:chat_app/domains/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
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
  Future<Either<FailureResponse, bool>> signUpWithEmailAndPassword(
      {required AuthWithEmailAndPasswordRequestEntity requestEntity}) async {
    try {
      final result = await authRemoteDataSource.signUpWithEmailAndPassword(
        requestDto: authMapper
            .mapAuthWithEmailAndPasswordRequestEntityToAuthWithEmailAndPasswordRequestDto(
          requestEntity,
        ),
      );
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
  Future<Either<FailureResponse, UserCredential>> signInWithEmailAndPassword(
      {required AuthWithEmailAndPasswordRequestEntity requestEntity}) async {
    try {
      final credential = await authRemoteDataSource.signInWithEmailAndPassword(
        requestDto: authMapper
            .mapAuthWithEmailAndPasswordRequestEntityToAuthWithEmailAndPasswordRequestDto(
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

  @override
  Future<Either<FailureResponse, NoParams>> signOut() async {
    try {
      await authRemoteDataSource.signOut();
      return const Right(NoParams());
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
