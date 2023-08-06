import 'package:dartz/dartz.dart';
import 'package:chat_app/domains/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';

class CacheTokenUseCase extends UseCase<bool, String> {
  final AuthRepository authRepository;

  CacheTokenUseCase({required this.authRepository});

  @override
  Future<Either<FailureResponse, bool>> call(String params) async =>
      await authRepository.cachedToken(token: params);
}
