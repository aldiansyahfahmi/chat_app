import 'package:chat_app/domains/chat/domain/entities/response/my_chat_data_entity.dart';
import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:equatable/equatable.dart';

class MyChatWithArgument extends Equatable {
  final UserDataEntity userDataEntity;
  final List<MyChatDataEntity> result;

  const MyChatWithArgument(
      {required this.userDataEntity, required this.result});

  @override
  List<Object?> get props => [userDataEntity, result];
}
