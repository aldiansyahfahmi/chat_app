import 'package:chat_app/domains/chat/domain/entities/response/my_chat_data_entity.dart';
import 'package:chat_app/domains/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class GetMyChatWithUseCase extends UseCase<List<MyChatDataEntity>, String> {
  final ChatRepository chatRepository;

  GetMyChatWithUseCase({required this.chatRepository});

  @override
  Future<Either<FailureResponse, List<MyChatDataEntity>>> call(
          String params) async =>
      await chatRepository.getMyChatWith(email: params);
}
