import 'package:dartz/dartz.dart';
import 'package:chat_app/domains/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';

class IsUserLoggedUseCase extends UseCase<bool, NoParams> {
  final AuthRepository authRepository;

  IsUserLoggedUseCase({required this.authRepository});

  @override
  Future<Either<FailureResponse, bool>> call(NoParams params) async =>
      await authRepository.isUserLogged();
}
