import 'package:chat_app/domains/chat/data/datasources/remote/chat_remote_datasource.dart';
import 'package:chat_app/domains/chat/data/mapper/chat_mapper.dart';
import 'package:chat_app/domains/chat/data/repositories/chat_repository_impl.dart';
import 'package:chat_app/domains/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app/domains/chat/domain/usecases/send_message_usecase.dart';
import 'package:chat_app/injections/injections.dart';

class ChatDependency {
  ChatDependency() {
    _registerDataSource();
    _registerMapper();
    _registerRepository();
    _registerUseCases();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(),
    );
  }

  void _registerMapper() {
    sl.registerLazySingleton<ChatMapper>(
      () => ChatMapper(),
    );
  }

  void _registerRepository() {
    sl.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(
        chatMapper: sl(),
        chatRemoteDataSoure: sl(),
      ),
    );
  }

  void _registerUseCases() {
    sl.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(
        chatRepository: sl(),
      ),
    );
  }
}
