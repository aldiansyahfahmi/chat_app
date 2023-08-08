import 'package:chat_app/domains/account/domain/entities/response/user_response_entity.dart';
import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class UserState extends Equatable {
  final ViewData<UserResponseEntity> userState;

  const UserState({required this.userState});

  @override
  List<Object?> get props => [userState];
}
