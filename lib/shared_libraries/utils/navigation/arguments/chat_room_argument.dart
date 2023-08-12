import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:equatable/equatable.dart';

class ChatRoomArgument extends Equatable {
  final UserDataEntity userDataEntity;
  final String chatId;

  const ChatRoomArgument({required this.userDataEntity, required this.chatId});

  @override
  List<Object?> get props => [userDataEntity, chatId];
}
