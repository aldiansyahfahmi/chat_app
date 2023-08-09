import 'package:chat_app/domains/chat/domain/entities/body/create_chat_room_request_entity.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<FailureResponse, NoParams>> sendMessage(
      {required CreateChatRoomRequestEntity requestEntity});
}
