import 'package:chat_app/domains/chat/data/models/body/create_chat_room_request_dto.dart';
import 'package:chat_app/domains/chat/domain/entities/body/create_chat_room_request_entity.dart';

class ChatMapper {
  CreateChatRoomRequestDto
      mapCreateChatRoomRequestEntityToCreateChatRoomRequestDto(
              CreateChatRoomRequestEntity data) =>
          CreateChatRoomRequestDto(
            participants: data.participants,
            toEmail: data.toEmail,
            lastMessage: data.lastMessage,
          );
}
