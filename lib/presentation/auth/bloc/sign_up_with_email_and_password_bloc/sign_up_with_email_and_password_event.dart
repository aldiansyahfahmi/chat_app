import 'package:chat_app/domains/auth/domain/entities/body/sign_up_with_email_and_password_request_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpWithEmailAndPasswordEvent extends Equatable {
  const SignUpWithEmailAndPasswordEvent();
}

class SignUpWithEmailAndPassword extends SignUpWithEmailAndPasswordEvent {
  final SignUpWithEmailAndPasswordRequestEntity
      signUpWithEmailAndPasswordRequestEntity;

  const SignUpWithEmailAndPassword(
      {required this.signUpWithEmailAndPasswordRequestEntity});

  @override
  List<Object?> get props => [signUpWithEmailAndPasswordRequestEntity];
}
