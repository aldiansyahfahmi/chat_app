import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class UserState extends Equatable {
  final ViewData<UserDataEntity> userState;

  const UserState({required this.userState});

  @override
  List<Object?> get props => [userState];
}
