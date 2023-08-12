import 'package:chat_app/domains/chat/domain/entities/body/create_chat_room_request_entity.dart';

class SendMessageRequestEntity {
  final CreateChatRoomRequestEntity createChatRoomRequestEntity;
  final String chatWith;
  final String message;

  SendMessageRequestEntity({
    required this.createChatRoomRequestEntity,
    required this.chatWith,
    required this.message,
  });
}
