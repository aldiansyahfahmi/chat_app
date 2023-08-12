import 'package:chat_app/domains/chat/domain/entities/body/send_message_request_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SendMessageEvent extends Equatable {
  const SendMessageEvent();
}

class SendMessage extends SendMessageEvent {
  final SendMessageRequestEntity sendMessageRequestEntity;

  const SendMessage({required this.sendMessageRequestEntity});

  @override
  List<Object?> get props => [sendMessageRequestEntity];
}
