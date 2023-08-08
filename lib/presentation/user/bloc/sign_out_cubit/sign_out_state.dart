import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class SignOutState extends Equatable {
  final ViewData signOutState;

  const SignOutState({required this.signOutState});

  @override
  List<Object?> get props => [signOutState];
}
