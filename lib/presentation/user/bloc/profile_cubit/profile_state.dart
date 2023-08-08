import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class ProfileState extends Equatable {
  final ViewData<UserDataEntity> profileState;

  const ProfileState({required this.profileState});

  @override
  List<Object?> get props => [profileState];
}
