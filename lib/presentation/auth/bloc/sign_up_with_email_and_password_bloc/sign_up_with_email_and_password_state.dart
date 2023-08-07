import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class SignUpWithEmailAndPasswordState extends Equatable {
  final ViewData<bool> signUpWithEmailAndPasswordState;

  const SignUpWithEmailAndPasswordState(
      {required this.signUpWithEmailAndPasswordState});

  @override
  List<Object?> get props => [signUpWithEmailAndPasswordState];
}
