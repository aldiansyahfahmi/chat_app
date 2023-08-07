import 'package:chat_app/domains/auth/data/models/body/sign_up_with_email_and_password_request_dto.dart';
import 'package:chat_app/domains/auth/domain/entities/body/sign_up_with_email_and_password_request_entity.dart';

class AuthMapper {
  SignUpWithEmailAndPasswordRequestDto
      mapSignUpWithEmailAndPasswordRequestEntityToSignUpWithEmailAndPasswordRequestDto(
              SignUpWithEmailAndPasswordRequestEntity requestEntity) =>
          SignUpWithEmailAndPasswordRequestDto(
            email: requestEntity.email,
            password: requestEntity.password,
          );
}
