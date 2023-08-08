import 'dart:async';

import 'package:chat_app/domains/user/data/models/response/user_data_dto.dart';
import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';

class UserMapper {
  Stream<UserDataEntity> mapUserDataDtoToUserDataEntity(
          Stream<UserDataDto> data) =>
      data.map(
        (event) => UserDataEntity(
          username: event.username ?? '',
          email: event.email ?? '',
          photo: event.photo ?? '',
        ),
      );
}
