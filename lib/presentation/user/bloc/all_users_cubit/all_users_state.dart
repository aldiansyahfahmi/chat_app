import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class AllUsersState extends Equatable {
  final ViewData<Stream<List<UserDataEntity>>> allUsersState;

  const AllUsersState({required this.allUsersState});

  @override
  List<Object?> get props => [allUsersState];
}
