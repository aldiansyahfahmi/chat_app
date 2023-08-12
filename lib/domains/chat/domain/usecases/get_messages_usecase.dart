import 'package:chat_app/domains/chat/domain/entities/response/message_data_entity.dart';
import 'package:chat_app/domains/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class GetMessagesUseCase
    extends UseCase<Stream<List<MessageDataEntity>>, String> {
  final ChatRepository chatRepository;

  GetMessagesUseCase({required this.chatRepository});

  @override
  Future<Either<FailureResponse, Stream<List<MessageDataEntity>>>> call(
          String params) async =>
      await chatRepository.getMessages(chatId: params);
}
