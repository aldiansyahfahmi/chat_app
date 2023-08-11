import 'package:chat_app/domains/chat/domain/entities/response/my_chat_data_entity.dart';
import 'package:chat_app/domains/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class GetMyChatsUseCase
    extends UseCase<Stream<List<MyChatDataEntity>>, NoParams> {
  final ChatRepository chatRepository;

  GetMyChatsUseCase({required this.chatRepository});

  @override
  Future<Either<FailureResponse, Stream<List<MyChatDataEntity>>>> call(
          NoParams params) async =>
      await chatRepository.getMyChats();
}
