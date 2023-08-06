import 'package:dartz/dartz.dart';
import 'package:chat_app/domains/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';

class GetTokenUseCase extends UseCase<String, NoParams> {
  final AuthRepository authRepository;

  GetTokenUseCase({required this.authRepository});

  @override
  Future<Either<FailureResponse, String>> call(NoParams params) async =>
      await authRepository.getToken();
}
