import 'package:dartz/dartz.dart';
import 'package:chat_app/domains/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';

class SignOutUseCase extends UseCase<NoParams, NoParams> {
  final AuthRepository authRepository;

  SignOutUseCase({required this.authRepository});

  @override
  Future<Either<FailureResponse, NoParams>> call(NoParams params) async =>
      await authRepository.signOut();
}
