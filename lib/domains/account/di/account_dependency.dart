import 'package:chat_app/domains/account/data/datasources/remote/account_remote_datasource.dart';
import 'package:chat_app/domains/account/data/mapper/account_mapper.dart';
import 'package:chat_app/domains/account/data/repositories/account_repository_impl.dart';
import 'package:chat_app/domains/account/domain/repositories/account_repository.dart';
import 'package:chat_app/domains/account/domain/usecases/get_user_by_id_usecase.dart';
import 'package:chat_app/domains/account/domain/usecases/get_user_usecase.dart';
import 'package:chat_app/injections/injections.dart';

class AccountDependency {
  AccountDependency() {
    _registerDataSource();
    _registerMapper();
    _registerRepository();
    _registerUseCases();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<AccountRemoteDataSource>(
      () => AccountRemoteDataSourceImpl(),
    );
  }

  void _registerMapper() {
    sl.registerLazySingleton<AccountMapper>(
      () => AccountMapper(),
    );
  }

  void _registerRepository() {
    sl.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(
        accountMapper: sl(),
        accountRemoteDataSource: sl(),
      ),
    );
  }

  void _registerUseCases() {
    sl.registerLazySingleton<GetUserUseCase>(
      () => GetUserUseCase(
        accountRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetUserByIdUseCase>(
      () => GetUserByIdUseCase(
        accountRepository: sl(),
      ),
    );
  }
}
