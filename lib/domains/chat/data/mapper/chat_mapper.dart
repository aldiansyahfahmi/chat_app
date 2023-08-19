import 'package:chat_app/domains/chat/data/models/body/create_chat_room_request_dto.dart';
import 'package:chat_app/domains/chat/data/models/body/send_message_request_dto.dart';
import 'package:chat_app/domains/chat/data/models/response/message_data_dto.dart';
import 'package:chat_app/domains/chat/data/models/response/my_chat_data_dto.dart';
import 'package:chat_app/domains/chat/domain/entities/body/create_chat_room_request_entity.dart';
import 'package:chat_app/domains/chat/domain/entities/body/send_message_request_entity.dart';
import 'package:chat_app/domains/chat/domain/entities/response/message_data_entity.dart';
import 'package:chat_app/domains/chat/domain/entities/response/my_chat_data_entity.dart';

class ChatMapper {
  SendMessageRequestDto mapSendMessageRequestEntityToSendMessageRequestDto(
          SendMessageRequestEntity data) =>
      SendMessageRequestDto(
        createChatRoomRequestDto:
            mapCreateChatRoomRequestEntityToCreateChatRoomRequestDto(
                data.createChatRoomRequestEntity),
        chatWith: data.chatWith,
        message: data.message,
      );

  CreateChatRoomRequestDto
      mapCreateChatRoomRequestEntityToCreateChatRoomRequestDto(
              CreateChatRoomRequestEntity data) =>
          CreateChatRoomRequestDto(
            participants: data.participants,
            lastMessage: data.lastMessage,
          );

  Stream<List<MyChatDataEntity>> mapStreamMyChatDataDtoToStreamEntity(
      Stream<List<MyChatDataDto>> data) {
    return data.map(
      (event) => mapMyChatDataDtoToEntity(event),
    );
  }

  Stream<MyChatDataEntity> mapStreamMyChatDataDtoToStreamMyChatDataEntity(
          Stream<MyChatDataDto> data) =>
      data.map(
        (event) => MyChatDataEntity(
          chatId: event.chatId ?? '',
          chatWith: event.chatWith ?? '',
          lastMessage: event.lastMessage ?? '',
          totalUnread: event.totalUnread ?? 0,
        ),
      );

  List<MyChatDataEntity> mapMyChatDataDtoToEntity(List<MyChatDataDto> data) {
    List<MyChatDataEntity> entity = <MyChatDataEntity>[];

    for (MyChatDataDto element in data) {
      entity.add(
        mapMyChatDataDtoToMyChatDataEntity(
          element,
        ),
      );
    }

    return entity;
  }

  MyChatDataEntity mapMyChatDataDtoToMyChatDataEntity(MyChatDataDto data) =>
      MyChatDataEntity(
          chatId: data.chatId ?? '',
          chatWith: data.chatWith ?? '',
          lastMessage: data.lastMessage ?? '',
          totalUnread: data.totalUnread ?? 0);

  Stream<List<MessageDataEntity>> mapStreamMessageDataDtoToStreamEntity(
      Stream<List<MessageDataDto>> data) {
    return data.map((event) => mapMessageDataDtoToEntity(event));
  }

  List<MessageDataEntity> mapMessageDataDtoToEntity(List<MessageDataDto> data) {
    List<MessageDataEntity> entity = <MessageDataEntity>[];

    for (MessageDataDto element in data) {
      entity.add(mapMessageDataDtoToMessageDataEntity(element));
    }

    return entity;
  }

  MessageDataEntity mapMessageDataDtoToMessageDataEntity(MessageDataDto data) =>
      MessageDataEntity(
        message: data.message,
        sender: data.sender,
        time: data.time,
      );
}
