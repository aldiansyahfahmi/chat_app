import 'package:chat_app/domains/auth/domain/entities/body/sign_in_with_email_and_password_request_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SignInWithEmailAndPasswordEvent extends Equatable {
  const SignInWithEmailAndPasswordEvent();
}

class SignInWithEmailAndPassword extends SignInWithEmailAndPasswordEvent {
  final SignInWithEmailAndPasswordRequestEntity
      authWithEmailAndPasswordRequestEntity;

  const SignInWithEmailAndPassword(
      {required this.authWithEmailAndPasswordRequestEntity});

  @override
  List<Object?> get props => [authWithEmailAndPasswordRequestEntity];
}
