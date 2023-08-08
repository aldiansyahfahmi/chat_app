import 'package:chat_app/domains/account/domain/entities/response/user_response_entity.dart';
import 'package:chat_app/domains/account/domain/repositories/account_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class GetUserByIdUseCase extends UseCase<Stream<UserResponseEntity>, String> {
  final AccountRepository accountRepository;

  GetUserByIdUseCase({required this.accountRepository});

  @override
  Future<Either<FailureResponse, Stream<UserResponseEntity>>> call(
          String params) =>
      accountRepository.getUserById(docId: params);
}
