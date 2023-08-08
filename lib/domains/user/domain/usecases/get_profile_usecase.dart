import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:chat_app/domains/user/domain/repositories/user_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class GetProfileUseCase extends UseCase<Stream<UserDataEntity>, NoParams> {
  final UserRepository userRepository;

  GetProfileUseCase({required this.userRepository});

  @override
  Future<Either<FailureResponse, Stream<UserDataEntity>>> call(
          NoParams params) =>
      userRepository.getProfile();
}
