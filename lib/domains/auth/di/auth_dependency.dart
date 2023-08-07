import 'package:chat_app/domains/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:chat_app/domains/auth/data/mapper/auth_mapper.dart';
import 'package:chat_app/domains/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app/domains/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/domains/auth/domain/usecases/is_user_logged_usecase.dart';
import 'package:chat_app/domains/auth/domain/usecases/sign_in_with_email_and_password_usecase.dart';
import 'package:chat_app/domains/auth/domain/usecases/sign_out_usecase.dart';
import 'package:chat_app/domains/auth/domain/usecases/sign_up_with_email_and_password_usecase.dart';
import 'package:chat_app/injections/injections.dart';

class AuthDependency {
  AuthDependency() {
    _registerDataSource();
    _registerMapper();
    _registerRepository();
    _registerUseCases();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    );
  }

  void _registerMapper() {
    sl.registerLazySingleton<AuthMapper>(() => AuthMapper());
  }

  void _registerRepository() {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: sl(),
        authMapper: sl(),
      ),
    );
  }

  void _registerUseCases() {
    sl.registerLazySingleton<IsUserLoggedUseCase>(
      () => IsUserLoggedUseCase(
        authRepository: sl(),
      ),
    );
    sl.registerLazySingleton<SignUpWithEmailAndPasswordUseCase>(
      () => SignUpWithEmailAndPasswordUseCase(
        authRepository: sl(),
      ),
    );
    sl.registerLazySingleton<SignInWithEmailAndPasswordUseCase>(
      () => SignInWithEmailAndPasswordUseCase(
        authRepository: sl(),
      ),
    );
    sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(
        authRepository: sl(),
      ),
    );
  }
}
