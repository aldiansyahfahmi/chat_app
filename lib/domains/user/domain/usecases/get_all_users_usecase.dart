import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:chat_app/domains/user/domain/repositories/user_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class GetAllUsersUseCase
    extends UseCase<Stream<List<UserDataEntity>>, NoParams> {
  final UserRepository userRepository;

  GetAllUsersUseCase({required this.userRepository});

  @override
  Future<Either<FailureResponse, Stream<List<UserDataEntity>>>> call(
          NoParams params) async =>
      await userRepository.getAllUsers();
}
