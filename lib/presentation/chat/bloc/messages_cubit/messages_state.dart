import 'package:chat_app/domains/chat/domain/entities/response/message_data_entity.dart';
import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class MessagesState extends Equatable {
  final ViewData<Stream<List<MessageDataEntity>>> messagesState;

  const MessagesState({required this.messagesState});

  @override
  List<Object?> get props => [messagesState];
}
