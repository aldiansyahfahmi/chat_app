import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class SignUpWithEmailAndPasswordState extends Equatable {
  final ViewData<UserCredential> signUpWithEmailAndPasswordState;

  const SignUpWithEmailAndPasswordState(
      {required this.signUpWithEmailAndPasswordState});

  @override
  List<Object?> get props => [signUpWithEmailAndPasswordState];
}
