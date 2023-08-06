import 'package:chat_app/domains/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:chat_app/domains/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app/domains/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/domains/auth/domain/usecases/cache_token_usecase.dart';
import 'package:chat_app/domains/auth/domain/usecases/get_token_usecase.dart';
import 'package:chat_app/domains/auth/domain/usecases/remove_user_data_usecase.dart';
import 'package:chat_app/injections/injections.dart';

class AuthDependency {
  AuthDependency() {
    _registerDataSource();
    _registerMapper();
    _registerRepository();
    _registerUseCases();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(),
    );
  }

  void _registerMapper() {}

  void _registerRepository() {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authLocalDataSource: sl()),
    );
  }

  void _registerUseCases() {
    sl.registerLazySingleton<CacheTokenUseCase>(
      () => CacheTokenUseCase(authRepository: sl()),
    );
    sl.registerLazySingleton<GetTokenUseCase>(
      () => GetTokenUseCase(authRepository: sl()),
    );
    sl.registerLazySingleton<RemoveUserDataUseCase>(
      () => RemoveUserDataUseCase(authRepository: sl()),
    );
  }
}
