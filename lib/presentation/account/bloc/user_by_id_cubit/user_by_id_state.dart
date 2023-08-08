import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class UserByIdState extends Equatable {
  final ViewData userByIdState;

  const UserByIdState({required this.userByIdState});

  @override
  List<Object?> get props => [userByIdState];
}
