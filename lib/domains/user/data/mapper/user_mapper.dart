import 'dart:async';

import 'package:chat_app/domains/user/data/models/response/user_data_dto.dart';
import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';

class UserMapper {
  Stream<List<UserDataEntity>> mapStreamUserDataDtoToStreamEntity(
      Stream<List<UserDataDto>> data) {
    return data.map(
      (event) => mapUserDataDtoToEntity(event),
    );
  }

  List<UserDataEntity> mapUserDataDtoToEntity(List<UserDataDto> data) {
    List<UserDataEntity> entity = <UserDataEntity>[];

    for (UserDataDto element in data) {
      entity.add(
        mapUserDataDtoToUserDataEntity(
          element,
        ),
      );
    }

    return entity;
  }

  UserDataEntity mapUserDataDtoToUserDataEntity(UserDataDto data) =>
      UserDataEntity(
        username: data.username ?? '',
        email: data.email ?? '',
        photo: data.photo ?? '',
      );

  Stream<UserDataEntity> mapStreamUserDataDtoToStreamUserDataEntity(
          Stream<UserDataDto> data) =>
      data.map(
        (event) => UserDataEntity(
          username: event.username ?? '',
          email: event.email ?? '',
          photo: event.photo ?? '',
        ),
      );
}
