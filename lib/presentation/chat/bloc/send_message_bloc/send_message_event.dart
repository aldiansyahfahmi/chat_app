import 'package:chat_app/domains/chat/domain/entities/body/create_chat_room_request_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SendMessageEvent extends Equatable {
  const SendMessageEvent();
}

class SendMessage extends SendMessageEvent {
  final CreateChatRoomRequestEntity sendMessageRequestEntity;

  const SendMessage({required this.sendMessageRequestEntity});

  @override
  List<Object?> get props => [sendMessageRequestEntity];
}
