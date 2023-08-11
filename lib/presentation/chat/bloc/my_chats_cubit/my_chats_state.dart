import 'package:chat_app/domains/chat/domain/entities/response/my_chat_data_entity.dart';
import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class MyChatsState extends Equatable {
  final ViewData<Stream<List<MyChatDataEntity>>> myChatsState;

  const MyChatsState({required this.myChatsState});

  @override
  List<Object?> get props => [myChatsState];
}
