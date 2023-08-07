import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class UserState extends Equatable {
  final ViewData<User> userState;

  const UserState({required this.userState});

  @override
  List<Object?> get props => [userState];
}
