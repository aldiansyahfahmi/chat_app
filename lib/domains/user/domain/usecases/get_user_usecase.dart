import 'package:chat_app/domains/user/domain/repositories/user_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUserUseCase extends UseCase<User, NoParams> {
  final UserRepository userRepository;

  GetUserUseCase({required this.userRepository});

  @override
  Future<Either<FailureResponse, User>> call(NoParams params) =>
      userRepository.getUser();
}
