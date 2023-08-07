import 'package:chat_app/domains/auth/domain/entities/body/auth_with_email_and_password_request_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_app/domains/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';

class SignUpWithEmailAndPasswordUseCase
    extends UseCase<bool, AuthWithEmailAndPasswordRequestEntity> {
  final AuthRepository authRepository;

  SignUpWithEmailAndPasswordUseCase({required this.authRepository});

  @override
  Future<Either<FailureResponse, bool>> call(
          AuthWithEmailAndPasswordRequestEntity params) async =>
      await authRepository.signUpWithEmailAndPassword(requestEntity: params);
}
