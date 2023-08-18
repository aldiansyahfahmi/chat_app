import 'package:chat_app/shared_libraries/utils/navigation/arguments/my_chat_with_argument.dart';
import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class MyChatWithState extends Equatable {
  final ViewData<MyChatWithArgument> myChatWithState;

  const MyChatWithState({required this.myChatWithState});

  @override
  List<Object?> get props => [myChatWithState];
}
