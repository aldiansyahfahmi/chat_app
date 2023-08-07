import 'package:chat_app/domains/auth/data/models/body/auth_with_email_and_password_request_dto.dart';
import 'package:chat_app/domains/auth/domain/entities/body/auth_with_email_and_password_request_entity.dart';

class AuthMapper {
  AuthWithEmailAndPasswordRequestDto
      mapAuthWithEmailAndPasswordRequestEntityToAuthWithEmailAndPasswordRequestDto(
              AuthWithEmailAndPasswordRequestEntity requestEntity) =>
          AuthWithEmailAndPasswordRequestDto(
            email: requestEntity.email,
            password: requestEntity.password,
          );
}
