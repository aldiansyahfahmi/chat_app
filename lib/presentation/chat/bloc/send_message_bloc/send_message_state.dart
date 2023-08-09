import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class SendMessageState extends Equatable {
  final ViewData sendMessageState;

  const SendMessageState({required this.sendMessageState});

  @override
  List<Object?> get props => [sendMessageState];
}
