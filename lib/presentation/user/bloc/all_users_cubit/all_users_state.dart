import 'package:chat_app/domains/user/data/models/response/user_data_dto.dart';
import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class AllUsersState extends Equatable {
  final ViewData<List<UserDataDto>> allUsersState;

  const AllUsersState({required this.allUsersState});

  @override
  List<Object?> get props => [allUsersState];
}
