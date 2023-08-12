import 'package:chat_app/domains/chat/domain/entities/body/send_message_request_entity.dart';
import 'package:chat_app/domains/chat/domain/entities/response/message_data_entity.dart';
import 'package:chat_app/domains/chat/domain/entities/response/my_chat_data_entity.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<FailureResponse, Stream<List<MyChatDataEntity>>>> getMyChats();
  Future<Either<FailureResponse, NoParams>> sendMessage(
      {required SendMessageRequestEntity requestEntity});
  Future<Either<FailureResponse, Stream<List<MessageDataEntity>>>> getMessages(
      {required String chatId});
}
