import 'package:chat_app/domains/account/data/models/response/user_response_dto.dart';
import 'package:chat_app/domains/account/domain/entities/response/user_response_entity.dart';

class AccountMapper {
  Stream<UserResponseEntity> mapUserResponseDtoToUserResponseEntity(
          Stream<UserResponseDto> data) =>
      data.map(
        (event) => UserResponseEntity(
          username: event.username ?? '',
          email: event.email ?? '',
          photo: event.photo ?? '',
        ),
      );
}
