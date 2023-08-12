import 'package:chat_app/domains/chat/domain/entities/body/send_message_request_entity.dart';
import 'package:chat_app/domains/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class SendMessageUseCase extends UseCase<NoParams, SendMessageRequestEntity> {
  final ChatRepository chatRepository;

  SendMessageUseCase({required this.chatRepository});

  @override
  Future<Either<FailureResponse, NoParams>> call(
          SendMessageRequestEntity params) async =>
      await chatRepository.sendMessage(requestEntity: params);
}
