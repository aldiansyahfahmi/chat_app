import 'package:chat_app/domains/chat/data/models/body/create_chat_room_request_dto.dart';
import 'package:chat_app/domains/chat/data/models/response/my_chat_data_dto.dart';
import 'package:chat_app/domains/chat/domain/entities/body/create_chat_room_request_entity.dart';
import 'package:chat_app/domains/chat/domain/entities/response/my_chat_data_entity.dart';

class ChatMapper {
  CreateChatRoomRequestDto
      mapCreateChatRoomRequestEntityToCreateChatRoomRequestDto(
              CreateChatRoomRequestEntity data) =>
          CreateChatRoomRequestDto(
            participants: data.participants,
            toEmail: data.toEmail,
            lastMessage: data.lastMessage,
          );

  Stream<List<MyChatDataEntity>> mapStreamMyChatDataDtoToStreamEntity(
      Stream<List<MyChatDataDto>> data) {
    return data.map(
      (event) => mapMyChatDataDtoToEntity(event),
    );
  }

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
        chatId: data.chatId,
        chatWith: data.chatWith,
      );
}
