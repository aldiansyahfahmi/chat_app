import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class SignInWithEmailAndPasswordState extends Equatable {
  final ViewData signInWithEmailAndPasswordState;

  const SignInWithEmailAndPasswordState({required this.signInWithEmailAndPasswordState});

  @override
  List<Object?> get props => [signInWithEmailAndPasswordState];
}
