import 'package:chat_app/domains/user/data/datasources/remote/user_remote_datasource.dart';
import 'package:chat_app/domains/user/data/mapper/user_mapper.dart';
import 'package:chat_app/domains/user/data/repositories/user_repository_impl.dart';
import 'package:chat_app/domains/user/domain/repositories/user_repository.dart';
import 'package:chat_app/domains/user/domain/usecases/get_all_users_usecase.dart';
import 'package:chat_app/domains/user/domain/usecases/get_user_by_id_usecase.dart';
import 'package:chat_app/injections/injections.dart';

class UserDependency {
  UserDependency() {
    _registerDataSource();
    _registerMapper();
    _registerRepository();
    _registerUseCases();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(),
    );
  }

  void _registerMapper() {
    sl.registerLazySingleton<UserMapper>(
      () => UserMapper(),
    );
  }

  void _registerRepository() {
    sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        userMapper: sl(),
        userRemoteDataSource: sl(),
      ),
    );
  }

  void _registerUseCases() {
    sl.registerLazySingleton<GetUserByIdUseCase>(
      () => GetUserByIdUseCase(
        userRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(
        userRepository: sl(),
      ),
    );
  }
}
